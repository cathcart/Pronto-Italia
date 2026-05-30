# Pronto Italia

Pronto Italia is a holiday-focused Italian app available in two forms: an installable web app for iPhone Home Screen use and the original SwiftUI iOS app. It is built around recognising practical words and chunks you are likely to hear while travelling: trains, restaurants, hotels, money, directions, social repair phrases, and emergencies.

## What is in the app

- **Today**: a 15-minute learning loop using spaced review, input flood, text reconstruction, and pushed output.
- **Phrases**: searchable travel phrasebook with Italian text, English meaning, useful chunks, notes, menu-decoder vocabulary, and text-to-speech pronunciation.
- **Review**: local spaced flashcards. Missed cards return quickly; confident cards move farther out.
- **Practice**: real holiday scenarios with recognition checks, phrase clusters, sentence reconstruction, dinner menu decoding, and spoken prompts.
- **Listen**: learner and native listening sources with small missions so listening stays active rather than passive.

## Research-informed choices

The learning loop intentionally combines:

- **Spaced retrieval** for long-term memory.
- **Input flood plus noticing** so the same phrase pattern appears repeatedly in context.
- **Lexical chunks** such as `vorrei`, `posso`, `a che ora`, `per favore`, and `ho bisogno di`.
- **Text reconstruction** to make word order and syntax more memorable.
- **Pushed output** so the learner has to produce useful phrases aloud.
- **Interaction-style repair phrases** such as `Può ripetere?` and `Può parlare più lentamente?`.

## Listening sources checked

These were checked on 19 May 2026 and included as external links in the app:

- Podcast Italiano Principiante: beginner, slow Italian, updated weekly, with transcript/glossary notes.
- News in Slow Italian: beginner/intermediate weekly news in plain language.
- Italiano ON-Air: weekly episodes with transcripts from Scuola Leonardo da Vinci.
- Coffee Break Italian: short beginner-friendly lessons.
- Italy Made Easy Podcast: slower Italian for listening comprehension.
- ANSA Voice: native Italian news podcasts for authentic input once learner audio feels too tidy.

## Installable web app

The GitHub Pages-ready Progressive Web App lives in `docs/`. It includes the phrasebook, Italian text-to-speech audio, local spaced review, scenario practice, and listening links. After the first online visit it caches the app screens for offline use, and review progress is stored on the device in the browser. External podcasts and news still require a connection.

To publish it from GitHub:

1. Create a GitHub repository and push this project to its `main` branch.
2. On GitHub, open **Settings > Pages** and set **Source** to **GitHub Actions**.
3. The included `.github/workflows/pages.yml` workflow publishes `docs/` after each push to `main`.
4. Open the published URL in Safari on the iPhone, tap **Share**, then choose **Add to Home Screen**.

On GitHub Free, a GitHub Pages site uses a public repository. If the source should remain private, the same `docs/` folder can be deployed to a private-repository-friendly host such as Cloudflare Pages instead.

For a local preview:

```bash
python3 -m http.server 4173 --directory docs
```

Then open `http://localhost:4173/`.

## Running the native iOS app

Open `ItalianHolidayTutor.xcodeproj` in Xcode, choose an iPhone simulator or your paired iPhone, and run the `Pronto Italia` target.

The native build has been verified with Xcode 26.5 for both the iPhone simulator and a generic iPhone device target. Its Swift sources also pass type checking.

The web app and the native app keep progress separately: browser storage for the web app and app storage for the SwiftUI version.

## Next good additions

- Add editable trip date and daily reminders.
- Add a tiny "custom phrase" deck for hotel names, allergies, itinerary places, and personal must-say lines.
- Add speech recognition for pronunciation self-checks once you are ready to handle microphone permissions.
