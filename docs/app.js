(function () {
  "use strict";

  const DATA = window.PRONTO_DATA;
  const STORAGE_KEY = "pronto-italia-progress-v1";
  const HOUR = 60 * 60 * 1000;
  const DAY = 24 * HOUR;
  const screen = document.getElementById("screen");
  const nav = document.querySelector(".tabbar");
  const networkLabel = document.getElementById("network-label");
  const installDialog = document.getElementById("install-dialog");

  function loadRecords() {
    try {
      return JSON.parse(localStorage.getItem(STORAGE_KEY) || "{}");
    } catch (error) {
      return {};
    }
  }

  const state = {
    view: "today",
    category: "all",
    query: "",
    reviewMode: "recognise",
    records: loadRecords(),
    reviewSession: [],
    reviewIndex: 0,
    reviewRevealed: false,
    reviewActive: false,
    scenarioId: DATA.scenarios[0].id,
    answer: "",
    builder: []
  };

  function escapeHTML(value) {
    return String(value).replace(/[&<>"']/g, function (character) {
      return {
        "&": "&amp;",
        "<": "&lt;",
        ">": "&gt;",
        "\"": "&quot;",
        "'": "&#39;"
      }[character];
    });
  }

  function phraseById(id) {
    return DATA.phrases.find(function (phrase) { return phrase.id === id; });
  }

  function categoryTitle(id) {
    const category = DATA.categories.find(function (item) { return item.id === id; });
    return category ? category.title : "All";
  }

  function saveRecords() {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(state.records));
  }

  function duePhrases() {
    const now = Date.now();
    return DATA.phrases.filter(function (phrase) {
      const record = state.records[phrase.id];
      return !record || record.dueAt <= now;
    });
  }

  function masteredCount() {
    return Object.values(state.records).filter(function (record) {
      return record.box >= 4;
    }).length;
  }

  function reviewedCount() {
    return Object.values(state.records).filter(function (record) {
      return Boolean(record.lastReviewed);
    }).length;
  }

  function startReview() {
    state.reviewSession = duePhrases().slice(0, 12).map(function (phrase) { return phrase.id; });
    state.reviewIndex = 0;
    state.reviewRevealed = false;
    state.reviewActive = true;
  }

  function speak(text) {
    if (!("speechSynthesis" in window)) {
      return;
    }
    window.speechSynthesis.cancel();
    const utterance = new SpeechSynthesisUtterance(text);
    utterance.lang = "it-IT";
    utterance.rate = 0.88;
    const voice = window.speechSynthesis.getVoices().find(function (availableVoice) {
      return availableVoice.lang.toLowerCase().startsWith("it");
    });
    if (voice) {
      utterance.voice = voice;
    }
    window.speechSynthesis.speak(utterance);
  }

  function renderToday() {
    const categories = DATA.categories.map(function (category) {
      const count = DATA.phrases.filter(function (phrase) { return phrase.category === category.id; }).length;
      return "<button class=\"category-tile\" type=\"button\" data-open-category=\"" + category.id + "\">" +
        "<strong>" + escapeHTML(category.title) + "</strong>" +
      "<small>" + count + " phrases - " + escapeHTML(category.cue) + "</small></button>";
    }).join("");

    const plan = DATA.dailyPlan.map(function (step) {
      return "<article class=\"method\"><span class=\"method-mark\">" + step.mark + "</span>" +
        "<div><h3>" + escapeHTML(step.title) + "</h3><p>" + escapeHTML(step.method) + "</p></div>" +
        "<span class=\"minutes\">" + step.minutes + " min</span></article>";
    }).join("");

    return "<section class=\"hero\"><div><h2>Italian for the moments that matter</h2>" +
      "<p>Recognise travel phrases, hear them aloud, then practise saying them before your holiday.</p>" +
      "<button class=\"action\" type=\"button\" data-start-review>Start review</button></div>" +
      "<img src=\"./assets/icon-512.png\" alt=\"Espresso cup and Italian train ticket\"></section>" +
      "<section class=\"metrics\" aria-label=\"Learning progress\">" +
      "<div class=\"metric\"><strong>" + duePhrases().length + "</strong><span>Due now</span></div>" +
      "<div class=\"metric\"><strong>" + masteredCount() + "</strong><span>Confident</span></div>" +
      "<div class=\"metric\"><strong>" + reviewedCount() + "</strong><span>Seen</span></div></section>" +
      "<div class=\"section-head\"><h2>Today, 15 minutes</h2><span>Research-informed loop</span></div>" +
      "<section class=\"method-list\">" + plan + "</section>" +
      "<div class=\"section-head\"><h2>Useful packs</h2><span>" + DATA.phrases.length + " phrases</span></div>" +
      "<section class=\"category-grid\">" + categories + "</section>";
  }

  function filteredPhrases() {
    const query = state.query.trim().toLocaleLowerCase("it");
    return DATA.phrases.filter(function (phrase) {
      const inCategory = state.category === "all" || phrase.category === state.category;
      const text = [phrase.italian, phrase.english, phrase.chunk, phrase.note].join(" ").toLocaleLowerCase("it");
      return inCategory && (!query || text.includes(query));
    });
  }

  function renderPhrases() {
    const chips = [{ id: "all", title: "All" }].concat(DATA.categories).map(function (category) {
      const selected = state.category === category.id ? " selected" : "";
      return "<button class=\"chip" + selected + "\" type=\"button\" data-category=\"" + category.id + "\">" +
        escapeHTML(category.title) + "</button>";
    }).join("");

    const phrases = filteredPhrases().map(function (phrase) {
      return "<article class=\"card phrase-card\"><div><span class=\"badge\">" +
        escapeHTML(categoryTitle(phrase.category)) + "</span><p class=\"phrase-it\">" +
        escapeHTML(phrase.italian) + "</p><p class=\"phrase-en\">" + escapeHTML(phrase.english) +
        "</p></div><button class=\"audio-button\" type=\"button\" data-speak=\"" + phrase.id +
        "\" aria-label=\"Play " + escapeHTML(phrase.italian) + "\">Play</button>" +
        "<p class=\"chunk\">Notice: " + escapeHTML(phrase.chunk) + " - " + escapeHTML(phrase.note) + "</p></article>";
    }).join("");

    return "<h2 class=\"page-title\">Phrasebook</h2>" +
      "<p class=\"page-subtitle\">Search the words you expect to hear in stations, restaurants and everyday exchanges.</p>" +
      "<label class=\"visually-hidden\" for=\"phrase-search\">Search phrases</label>" +
      "<input class=\"search\" id=\"phrase-search\" type=\"search\" value=\"" + escapeHTML(state.query) +
      "\" placeholder=\"Search Italian or English\" autocomplete=\"off\">" +
      "<div class=\"chips\" aria-label=\"Phrase categories\">" + chips + "</div>" +
      "<section class=\"phrase-list\">" + (phrases || "<p class=\"empty\">No phrases match that search.</p>") + "</section>";
  }

  function renderReview() {
    if (!state.reviewActive) {
      startReview();
    }
    if (!state.reviewSession.length || state.reviewIndex >= state.reviewSession.length) {
      const line = duePhrases().length ?
        "You still have phrases ready for another short round." :
        "Nothing is due just now. New review cards will appear as memory needs them.";
      return "<h2 class=\"page-title\">Review</h2><p class=\"page-subtitle\">Spaced retrieval for long-term recall.</p>" +
        "<section class=\"completion\"><h3>Session complete</h3><p>" + line + "</p>" +
        "<button class=\"action\" type=\"button\" data-new-review>Review due cards</button></section>";
    }

    const phrase = phraseById(state.reviewSession[state.reviewIndex]);
    const recognising = state.reviewMode === "recognise";
    const prompt = recognising ? phrase.italian : phrase.english;
    const answer = recognising ? phrase.english : phrase.italian;
    const answerHTML = state.reviewRevealed ?
      "<div class=\"answer\"><strong>" + escapeHTML(answer) + "</strong><p>Chunk: " +
      escapeHTML(phrase.chunk) + " - " + escapeHTML(phrase.note) + "</p></div>" :
      "<button class=\"action secondary full\" type=\"button\" data-reveal>Reveal answer</button>";
    const disabled = state.reviewRevealed ? "" : " disabled";

    return "<h2 class=\"page-title\">Review</h2><p class=\"page-subtitle\">Card " + (state.reviewIndex + 1) +
      " of " + state.reviewSession.length + ". Try to answer before revealing.</p>" +
      "<div class=\"segmented\" aria-label=\"Review direction\">" +
      "<button type=\"button\" data-mode=\"recognise\" class=\"" + (recognising ? "active" : "") +
      "\">Recognise</button><button type=\"button\" data-mode=\"produce\" class=\"" +
      (!recognising ? "active" : "") + "\">Produce</button></div>" +
      "<section class=\"study-card\"><p class=\"prompt-label\">" +
      (recognising ? "What does this mean?" : "Say this in Italian") + "</p>" +
      "<p class=\"prompt\">" + escapeHTML(prompt) + "</p>" + answerHTML + "</section>" +
      "<div class=\"grades\" aria-label=\"How well did you recall it?\">" +
      "<button class=\"grade again\" type=\"button\" data-grade=\"again\"" + disabled + ">Again</button>" +
      "<button class=\"grade\" type=\"button\" data-grade=\"hard\"" + disabled + ">Hard</button>" +
      "<button class=\"grade good\" type=\"button\" data-grade=\"good\"" + disabled + ">Got it</button>" +
      "<button class=\"grade easy\" type=\"button\" data-grade=\"easy\"" + disabled + ">Easy</button></div>";
  }

  function currentScenario() {
    return DATA.scenarios.find(function (scenario) { return scenario.id === state.scenarioId; });
  }

  function renderPractice() {
    const scenario = currentScenario();
    const tabs = DATA.scenarios.map(function (item) {
      return "<button class=\"chip" + (item.id === scenario.id ? " selected" : "") +
        "\" type=\"button\" data-scenario=\"" + item.id + "\">" + escapeHTML(item.title) + "</button>";
    }).join("");
    const focusedPhrases = scenario.phraseIds.map(function (id) {
      const phrase = phraseById(id);
      return "<div class=\"mini\"><div><strong>" + escapeHTML(phrase.italian) + "</strong><span>" +
        escapeHTML(phrase.english) + "</span></div><button class=\"audio-button\" type=\"button\" data-speak=\"" +
        phrase.id + "\" aria-label=\"Play pronunciation\">Play</button></div>";
    }).join("");
    const options = scenario.question.options.map(function (option) {
      let status = "";
      if (state.answer) {
        status = option === scenario.question.answer ? " correct" : (option === state.answer ? " wrong" : "");
      }
      return "<button class=\"option" + status + "\" type=\"button\" data-answer=\"" +
        escapeHTML(option) + "\">" + escapeHTML(option) + "</button>";
    }).join("");
    const feedback = state.answer ?
      "<p class=\"feedback\">" + (state.answer === scenario.question.answer ? "Correct. " : "Not quite. ") +
      escapeHTML(scenario.question.explanation) + "</p>" : "";
    const chosenText = state.builder.map(function (index) {
      return scenario.reconstruction.words[index];
    }).join(" ");
    const complete = state.builder.length === scenario.reconstruction.words.length;
    const correctBuild = chosenText === scenario.reconstruction.target;
    const buildFeedback = complete ?
      "<p class=\"feedback " + (correctBuild ? "" : "incorrect") + "\">" +
      (correctBuild ? "Correct. Say it once aloud." : "Try again: the order is not quite right.") + "</p>" : "";
    const tokens = scenario.reconstruction.words.map(function (word, index) {
      if (state.builder.includes(index)) {
        return "";
      }
      return "<button type=\"button\" class=\"token\" data-token=\"" + index + "\">" + escapeHTML(word) + "</button>";
    }).join("");

    return "<h2 class=\"page-title\">Practice</h2>" +
      "<p class=\"page-subtitle\">Repeat one real situation with small variations until the words arrive faster.</p>" +
      "<div class=\"chips\" aria-label=\"Travel situations\">" + tabs + "</div>" +
      "<section class=\"scenario-head\"><h2>" + escapeHTML(scenario.title) + " - " +
      escapeHTML(scenario.setting) + "</h2><p>" + escapeHTML(scenario.goal) + "</p>" +
      "<div class=\"focus-row\">" + scenario.chunks.map(function (chunk) {
        return "<span>" + escapeHTML(chunk) + "</span>";
      }).join("") + "</div></section>" +
      "<div class=\"mini-phrases\">" + focusedPhrases + "</div>" +
      "<section class=\"quiz\"><h3>Recognise the meaning</h3><p class=\"question\">" +
      escapeHTML(scenario.question.prompt) + "</p><div class=\"option-list\">" + options + "</div>" + feedback + "</section>" +
      "<section class=\"builder\"><h3>Build the line</h3><p class=\"muted\">" +
      escapeHTML(scenario.reconstruction.prompt) + "</p><div class=\"build-slot\">" +
      (chosenText ? escapeHTML(chosenText) : "Tap the words in order") + "</div>" +
      "<div class=\"tokens\">" + tokens + "</div><button type=\"button\" class=\"action secondary\" data-reset-build>Reset</button>" +
      buildFeedback + "</section>" +
      "<section class=\"output\"><h3>Say it aloud</h3><p class=\"question\">" +
      escapeHTML(scenario.output) + "</p></section>";
  }

  function renderListen() {
    const resources = DATA.listeningResources.map(function (resource) {
      return "<article class=\"resource\"><div class=\"resource-top\"><div><h3>" +
        escapeHTML(resource.title) + "</h3><span class=\"resource-tag\">" + escapeHTML(resource.level) +
        " - " + escapeHTML(resource.cadence) + "</span></div><span class=\"online-badge\">Online</span></div>" +
        "<p>" + escapeHTML(resource.why) + "</p><p class=\"mission\"><strong>Mission:</strong> " +
        escapeHTML(resource.mission) + "</p><a href=\"" + escapeHTML(resource.url) +
        "\" target=\"_blank\" rel=\"noopener noreferrer\">Open source</a></article>";
    }).join("");
    return "<h2 class=\"page-title\">Listen</h2>" +
      "<p class=\"page-subtitle\">Real voices make the tidy phrasebook useful in a noisy cafe or station. External audio needs internet.</p>" +
      "<section class=\"listening-note\"><strong>Active listening</strong><p>Choose a short item. Listen once for the situation, then again for familiar chunks such as <em>per favore</em> or <em>a che ora</em>.</p></section>" +
      "<section class=\"resource-list\">" + resources + "</section>";
  }

  function render() {
    const views = {
      today: renderToday,
      phrases: renderPhrases,
      review: renderReview,
      practice: renderPractice,
      listen: renderListen
    };
    screen.innerHTML = views[state.view]();
    nav.querySelectorAll("[data-nav]").forEach(function (button) {
      button.classList.toggle("active", button.dataset.nav === state.view);
      button.setAttribute("aria-current", button.dataset.nav === state.view ? "page" : "false");
    });
  }

  function gradeCard(grade) {
    const id = state.reviewSession[state.reviewIndex];
    const old = state.records[id] || { box: 0, streak: 0 };
    let box = old.box;
    let streak = old.streak;
    let interval = DAY;
    if (grade === "again") {
      box = 1;
      streak = 0;
      interval = 8 * HOUR;
    } else if (grade === "hard") {
      box = Math.max(1, box);
      interval = DAY;
    } else if (grade === "good") {
      box = Math.min(5, box + 1);
      streak += 1;
      interval = [DAY, 2 * DAY, 4 * DAY, 7 * DAY, 14 * DAY][box - 1];
    } else {
      box = Math.min(5, box + 2);
      streak += 1;
      interval = [DAY, 2 * DAY, 4 * DAY, 7 * DAY, 14 * DAY][box - 1];
    }
    state.records[id] = {
      box: box,
      streak: streak,
      dueAt: Date.now() + interval,
      lastReviewed: Date.now()
    };
    saveRecords();
    state.reviewIndex += 1;
    state.reviewRevealed = false;
    render();
  }

  document.addEventListener("click", function (event) {
    const button = event.target.closest("button");
    if (!button) {
      return;
    }
    if (button.dataset.nav) {
      state.view = button.dataset.nav;
      render();
    } else if (button.hasAttribute("data-start-review")) {
      startReview();
      state.view = "review";
      render();
    } else if (button.hasAttribute("data-new-review")) {
      startReview();
      render();
    } else if (button.dataset.openCategory) {
      state.view = "phrases";
      state.category = button.dataset.openCategory;
      render();
    } else if (button.dataset.category) {
      state.category = button.dataset.category;
      render();
    } else if (button.dataset.speak) {
      speak(phraseById(button.dataset.speak).italian);
    } else if (button.dataset.mode) {
      state.reviewMode = button.dataset.mode;
      state.reviewRevealed = false;
      render();
    } else if (button.hasAttribute("data-reveal")) {
      state.reviewRevealed = true;
      render();
    } else if (button.dataset.grade) {
      gradeCard(button.dataset.grade);
    } else if (button.dataset.scenario) {
      state.scenarioId = button.dataset.scenario;
      state.answer = "";
      state.builder = [];
      render();
    } else if (button.dataset.answer) {
      state.answer = button.dataset.answer;
      render();
    } else if (button.dataset.token) {
      state.builder.push(Number(button.dataset.token));
      render();
    } else if (button.hasAttribute("data-reset-build")) {
      state.builder = [];
      render();
    }
  });

  screen.addEventListener("input", function (event) {
    if (event.target.id === "phrase-search") {
      state.query = event.target.value;
      render();
      document.getElementById("phrase-search").focus();
    }
  });

  document.getElementById("install-open").addEventListener("click", function () {
    installDialog.showModal();
  });

  function updateConnection() {
    const dot = networkLabel.querySelector(".status-dot");
    const message = navigator.onLine ? "Online - offline enabled" : "Offline ready";
    dot.classList.toggle("online", navigator.onLine);
    networkLabel.lastChild.textContent = " " + message;
  }

  window.addEventListener("online", updateConnection);
  window.addEventListener("offline", updateConnection);
  updateConnection();
  render();

  if ("serviceWorker" in navigator) {
    window.addEventListener("load", function () {
      navigator.serviceWorker.register("./sw.js");
    });
  }
}());
