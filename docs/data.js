(function () {
  "use strict";

  const categories = [
    { id: "travel", title: "Travel", cue: "Trains and taxis" },
    { id: "food", title: "Food", cue: "Restaurants and menus" },
    { id: "money", title: "Money", cue: "Cards and cash" },
    { id: "hotel", title: "Hotel", cue: "Reception and rooms" },
    { id: "directions", title: "Directions", cue: "Finding your way" },
    { id: "social", title: "Social", cue: "Repair and courtesy" },
    { id: "emergency", title: "Emergency", cue: "Essential help" }
  ];

  const phrases = [
    ["travel-ticket-rome", "travel", "Un biglietto per Roma, per favore.", "A ticket to Rome, please.", "per favore", "Swap Roma for your destination."],
    ["travel-platform", "travel", "Da quale binario parte il treno?", "Which platform does the train leave from?", "da quale binario", "Binario is the key station word."],
    ["travel-time", "travel", "A che ora parte?", "What time does it leave?", "a che ora", "Useful for trains, buses and tours."],
    ["travel-return", "travel", "Andata e ritorno, per favore.", "Return ticket, please.", "andata e ritorno", "For one-way, say solo andata."],
    ["travel-delay", "travel", "Il treno è in ritardo?", "Is the train delayed?", "in ritardo", "Watch for this on departure boards."],
    ["travel-taxi", "travel", "Vorrei prendere un taxi.", "I would like to take a taxi.", "vorrei prendere", "Vorrei is a polite workhorse."],
    ["travel-stop-here", "travel", "Può fermarsi qui?", "Can you stop here?", "può", "A useful taxi request."],
    ["food-table", "food", "Un tavolo per due, per favore.", "A table for two, please.", "per due", "Swap due for your party size."],
    ["food-menu", "food", "Posso vedere il menù?", "Can I see the menu?", "posso vedere", "Posso means can I."],
    ["food-recommend", "food", "Che cosa mi consiglia?", "What do you recommend?", "mi consiglia", "Invites local advice."],
    ["food-order", "food", "Vorrei ordinare questo.", "I would like to order this.", "vorrei ordinare", "Pointing and questo help."],
    ["food-water", "food", "Acqua naturale o frizzante?", "Still or sparkling water?", "naturale o frizzante", "A phrase you will often hear."],
    ["food-vegetarian", "food", "Sono vegetariano.", "I am vegetarian.", "sono", "Use vegetariana for feminine agreement."],
    ["food-gluten", "food", "Avete qualcosa senza glutine?", "Do you have anything gluten-free?", "senza glutine", "Senza means without."],
    ["food-bill", "food", "Il conto, per favore.", "The bill, please.", "il conto", "Short and essential."],
    ["food-menu-antipasti", "food", "Antipasti", "Starters or appetisers.", "anti", "Often small plates before pasta or a main course."],
    ["food-menu-primi", "food", "Primi piatti", "First courses, usually pasta, risotto, soup, or gnocchi.", "primi", "Primi are normally not the main meat or fish course."],
    ["food-menu-secondi", "food", "Secondi piatti", "Second courses, usually meat, fish, or a main protein.", "secondi", "Side dishes often need to be ordered separately."],
    ["food-menu-contorni", "food", "Contorni", "Side dishes.", "contorni", "Look here for vegetables, potatoes, salad, and sides."],
    ["food-menu-dolci", "food", "Dolci", "Desserts.", "dolci", "You may also see dessert listed as dessert or dolce."],
    ["food-menu-coperto", "food", "Coperto", "Cover charge.", "coperto", "A per-person table charge that can appear on the bill."],
    ["food-menu-service", "food", "Servizio incluso", "Service included.", "servizio", "Useful to recognise before adding an extra tip."],
    ["food-menu-dish-day", "food", "Qual è il piatto del giorno?", "What is the dish of the day?", "piatto del giorno", "A good way to ask about a fresh or daily special."],
    ["food-menu-al-forno", "food", "Al forno", "Baked or oven-cooked.", "forno", "You will see this with pasta, vegetables, fish, or potatoes."],
    ["food-menu-alla-griglia", "food", "Alla griglia", "Grilled.", "griglia", "Common with fish, steak, vegetables, and chicken."],
    ["food-menu-fritto", "food", "Fritto", "Fried.", "fritto", "Fritto misto is mixed fried seafood or vegetables."],
    ["food-menu-crudo", "food", "Crudo", "Raw or cured.", "crudo", "Often appears with fish, seafood, ham, or carpaccio."],
    ["food-menu-affumicato", "food", "Affumicato", "Smoked.", "affumicato", "Useful for fish, cheese, and cured meat descriptions."],
    ["food-menu-piccante", "food", "È piccante?", "Is it spicy?", "piccante", "A compact question before ordering."],
    ["food-menu-pomodoro", "food", "Al pomodoro", "With tomato sauce.", "pomodoro", "A very common pasta and sauce word."],
    ["food-menu-funghi", "food", "Ai funghi", "With mushrooms.", "funghi", "Funghi can appear with pasta, pizza, risotto, or meat."],
    ["food-menu-tartufo", "food", "Al tartufo", "With truffle.", "tartufo", "Often found in pasta, risotto, eggs, and sauces."],
    ["food-menu-frutti-mare", "food", "Frutti di mare", "Seafood.", "mare", "Literally fruits of the sea."],
    ["food-menu-cozze", "food", "Cozze", "Mussels.", "cozze", "Useful for seafood pasta and starters."],
    ["food-menu-vongole", "food", "Vongole", "Clams.", "vongole", "Spaghetti alle vongole is a classic menu item."],
    ["food-menu-gamberi", "food", "Gamberi", "Prawns or shrimp.", "gamberi", "Look for gamberi in pasta, salads, and seafood dishes."],
    ["food-menu-pesce-giorno", "food", "Pesce del giorno", "Fish of the day.", "pesce", "Ask how it is cooked if the menu is brief."],
    ["food-menu-branzino", "food", "Branzino", "Sea bass.", "branzino", "A common whole fish or fillet on dinner menus."],
    ["food-menu-orata", "food", "Orata", "Sea bream.", "orata", "Common grilled or baked."],
    ["food-menu-bistecca", "food", "Bistecca", "Steak.", "bistecca", "Bistecca alla fiorentina is a famous Tuscan steak."],
    ["food-menu-pollo", "food", "Pollo", "Chicken.", "pollo", "A simple high-frequency meat word."],
    ["food-menu-maiale", "food", "Maiale", "Pork.", "maiale", "Useful if you avoid pork."],
    ["food-menu-agnello", "food", "Agnello", "Lamb.", "agnello", "Often roasted, grilled, or served as chops."],
    ["food-menu-risotto", "food", "Risotto", "Creamy rice dish.", "risotto", "Often a primo, not a side dish."],
    ["food-menu-gnocchi", "food", "Gnocchi", "Small potato dumplings.", "gnocchi", "Usually served as a first course with sauce."],
    ["food-menu-ravioli", "food", "Ravioli", "Stuffed pasta parcels.", "ravioli", "Often filled with ricotta, spinach, meat, or pumpkin."],
    ["food-menu-tagliatelle-ragu", "food", "Tagliatelle al ragù", "Ribbon pasta with meat sauce.", "ragù", "Ragù usually means a slow-cooked meat sauce."],
    ["food-menu-tiramisu", "food", "Tiramisù", "Coffee and mascarpone dessert.", "tiramisù", "One of the most recognisable Italian desserts."],
    ["food-menu-panna-cotta", "food", "Panna cotta", "Set cream dessert.", "panna", "Panna means cream."],
    ["food-menu-vino-casa", "food", "Vino della casa", "House wine.", "vino", "Often available by glass, carafe, half litre, or litre."],
    ["food-menu-contains-nuts", "food", "Contiene noci?", "Does it contain nuts?", "contiene", "Contiene means contains."],
    ["food-menu-dairy-free", "food", "Senza latticini", "Dairy-free.", "senza", "Useful for recognising or requesting no dairy."],
    ["money-cost", "money", "Quanto costa?", "How much does it cost?", "quanto costa", "Your core shopping question."],
    ["money-card", "money", "Posso pagare con carta?", "Can I pay by card?", "pagare con carta", "Carta means card here."],
    ["money-cash", "money", "Accettate contanti?", "Do you accept cash?", "contanti", "Listen for contanti: cash."],
    ["money-atm", "money", "Dov'è un bancomat?", "Where is an ATM?", "dov'è", "Bancomat is commonly used for ATM."],
    ["money-receipt", "money", "Posso avere lo scontrino?", "Can I have the receipt?", "posso avere", "Useful after small purchases."],
    ["money-cheaper", "money", "Avete qualcosa di più economico?", "Do you have something cheaper?", "più economico", "Useful in shops and markets."],
    ["hotel-reservation", "hotel", "Ho una prenotazione.", "I have a reservation.", "ho una", "Start here at reception."],
    ["hotel-name", "hotel", "La prenotazione è a nome di Cathcart.", "The reservation is under the name Cathcart.", "a nome di", "Replace the surname with yours."],
    ["hotel-checkout", "hotel", "A che ora è il check-out?", "What time is check-out?", "a che ora", "The same chunk asks breakfast time."],
    ["hotel-breakfast", "hotel", "La colazione è inclusa?", "Is breakfast included?", "è inclusa", "Colazione is breakfast."],
    ["hotel-ac", "hotel", "C'è l'aria condizionata?", "Is there air conditioning?", "c'è", "Useful in summer."],
    ["hotel-key", "hotel", "Ho perso la chiave.", "I lost the key.", "ho perso", "Chiave is key."],
    ["directions-excuse", "directions", "Mi scusi, dov'è la stazione?", "Excuse me, where is the station?", "mi scusi", "A polite opener with strangers."],
    ["directions-left", "directions", "Giri a sinistra.", "Turn left.", "a sinistra", "Sinistra means left."],
    ["directions-right", "directions", "Giri a destra.", "Turn right.", "a destra", "Destra means right."],
    ["directions-straight", "directions", "Vada sempre dritto.", "Go straight ahead.", "sempre dritto", "Common in spoken directions."],
    ["directions-near", "directions", "È vicino o lontano?", "Is it near or far?", "vicino o lontano", "Useful before deciding to walk."],
    ["directions-map", "directions", "Può indicarmelo sulla mappa?", "Can you show it to me on the map?", "sulla mappa", "Useful when speech is fast."],
    ["social-hello", "social", "Buongiorno.", "Good morning or good day.", "buon", "A safe greeting in shops and cafes."],
    ["social-thanks", "social", "Grazie mille.", "Thanks a lot.", "grazie", "A warm thank you."],
    ["social-slowly", "social", "Può parlare più lentamente?", "Can you speak more slowly?", "più lentamente", "An excellent learner rescue line."],
    ["social-repeat", "social", "Può ripetere, per favore?", "Can you repeat that, please?", "può ripetere", "Try this before switching language."],
    ["social-learning", "social", "Sto imparando l'italiano.", "I am learning Italian.", "sto imparando", "Often earns patience."],
    ["social-english", "social", "Parla inglese?", "Do you speak English?", "parla", "Polite and direct."],
    ["emergency-help", "emergency", "Aiuto!", "Help!", "aiuto", "Recognise this immediately."],
    ["emergency-doctor", "emergency", "Ho bisogno di un medico.", "I need a doctor.", "ho bisogno di", "Bisogno means need."],
    ["emergency-pharmacy", "emergency", "Dov'è la farmacia più vicina?", "Where is the nearest pharmacy?", "più vicina", "Farmacia signs are useful landmarks."],
    ["emergency-allergy", "emergency", "Sono allergico alle noci.", "I am allergic to nuts.", "sono allergico", "Use allergica for feminine agreement."],
    ["emergency-lost", "emergency", "Mi sono perso.", "I am lost.", "mi sono perso", "Use persa for feminine agreement."],
    ["emergency-police", "emergency", "Chiami la polizia, per favore.", "Call the police, please.", "chiami", "For urgent situations."]
  ].map(function (item) {
    return {
      id: item[0],
      category: item[1],
      italian: item[2],
      english: item[3],
      chunk: item[4],
      note: item[5]
    };
  });

  const dailyPlan = [
    { mark: "1", title: "Spaced review", minutes: 5, method: "Recall older cards before new ones." },
    { mark: "2", title: "Input flood", minutes: 4, method: "Hear related lines and spot repeated chunks." },
    { mark: "3", title: "Build the line", minutes: 3, method: "Reconstruct a useful sentence." },
    { mark: "4", title: "Say it aloud", minutes: 3, method: "Answer a travel moment from memory." }
  ];

  const scenarios = [
    {
      id: "station",
      title: "At the station",
      setting: "Ticket office",
      goal: "Buy the right ticket and recognise platform information.",
      chunks: ["un biglietto", "a che ora", "da quale binario", "in ritardo"],
      phraseIds: ["travel-ticket-rome", "travel-platform", "travel-time", "travel-return", "travel-delay"],
      question: {
        prompt: "You hear: Da quale binario parte il treno?",
        options: ["Which platform?", "How much?", "Where is the hotel?"],
        answer: "Which platform?",
        explanation: "Binario is the station word for platform."
      },
      reconstruction: {
        prompt: "A ticket to Rome, please.",
        target: "Un biglietto per Roma, per favore.",
        words: ["Roma,", "favore.", "per", "Un", "biglietto", "per"]
      },
      output: "Ask for a return ticket, then ask what time the train leaves."
    },
    {
      id: "restaurant",
      title: "Dinner booking",
      setting: "Restaurant",
      goal: "Get a table, understand water choices, and ask for the bill.",
      chunks: ["un tavolo", "mi consiglia", "senza glutine", "il conto"],
      phraseIds: ["food-table", "food-menu", "food-water", "food-recommend", "food-bill"],
      question: {
        prompt: "The waiter asks: Acqua naturale o frizzante?",
        options: ["Still or sparkling water?", "Cash or card?", "Inside or outside?"],
        answer: "Still or sparkling water?",
        explanation: "Naturale is still water; frizzante is sparkling."
      },
      reconstruction: {
        prompt: "The bill, please.",
        target: "Il conto, per favore.",
        words: ["favore.", "conto,", "Il", "per"]
      },
      output: "Ask for a table for two, choose sparkling water, then ask for the bill."
    },
    {
      id: "menu",
      title: "Reading the menu",
      setting: "Trattoria menu",
      goal: "Decode courses, cooking styles, seafood, meat, and dessert before ordering.",
      chunks: ["primi piatti", "secondi piatti", "alla griglia", "frutti di mare", "piatto del giorno"],
      phraseIds: ["food-menu-antipasti", "food-menu-primi", "food-menu-secondi", "food-menu-contorni", "food-menu-alla-griglia", "food-menu-frutti-mare", "food-menu-pesce-giorno", "food-menu-tiramisu", "food-menu-coperto"],
      question: {
        prompt: "On the menu you see contorni.",
        options: ["Side dishes", "Desserts", "Service included"],
        answer: "Side dishes",
        explanation: "Contorni are side dishes such as vegetables, potatoes, or salad."
      },
      reconstruction: {
        prompt: "What is the dish of the day?",
        target: "Qual è il piatto del giorno?",
        words: ["giorno?", "è", "piatto", "Qual", "del", "il"]
      },
      output: "Ask what the dish of the day is, then ask whether a dish contains nuts."
    },
    {
      id: "directions",
      title: "Finding your way",
      setting: "Street corner",
      goal: "Ask for directions and recognise the reply.",
      chunks: ["mi scusi", "a sinistra", "a destra", "sempre dritto"],
      phraseIds: ["directions-excuse", "directions-left", "directions-right", "directions-straight", "directions-near"],
      question: {
        prompt: "Someone says: Giri a destra.",
        options: ["Turn right", "Turn left", "Go straight"],
        answer: "Turn right",
        explanation: "Destra is right; sinistra is left."
      },
      reconstruction: {
        prompt: "Excuse me, where is the station?",
        target: "Mi scusi, dov'è la stazione?",
        words: ["la", "Mi", "stazione?", "dov'è", "scusi,"]
      },
      output: "Ask where the station is, then ask whether it is near or far."
    },
    {
      id: "hotel",
      title: "Checking in",
      setting: "Hotel reception",
      goal: "Check in and ask practical questions.",
      chunks: ["ho una prenotazione", "a nome di", "è inclusa", "c'è"],
      phraseIds: ["hotel-reservation", "hotel-name", "hotel-checkout", "hotel-breakfast", "hotel-ac"],
      question: {
        prompt: "Reception asks for a nome di.",
        options: ["The name on the booking", "Your room key", "Breakfast time"],
        answer: "The name on the booking",
        explanation: "A nome di means under the name of."
      },
      reconstruction: {
        prompt: "I have a reservation.",
        target: "Ho una prenotazione.",
        words: ["prenotazione.", "una", "Ho"]
      },
      output: "Say you have a reservation, give the name, then ask about check-out."
    }
  ];

  const listeningResources = [
    {
      title: "Podcast Italiano Principiante",
      level: "Beginner",
      cadence: "Guided listening",
      url: "https://www.podcastitaliano.com/en/podcast/principiante",
      why: "Slow natural Italian with stories and learner support.",
      mission: "Listen once for gist, then replay and write five words you recognise."
    },
    {
      title: "News in Slow Italian",
      level: "Beginner to intermediate",
      cadence: "Current news",
      url: "https://www.newsinslowitalian.com/home/news",
      why: "News themes introduce high-frequency language beyond travel.",
      mission: "Choose one headline and notice every familiar word."
    },
    {
      title: "Italiano ON-Air",
      level: "Beginner to intermediate",
      cadence: "Audio with transcript",
      url: "https://podcast.scuolaleonardo.com/",
      why: "Transcripts support noticing vocabulary and pronunciation.",
      mission: "Read after listening and keep one reusable holiday phrase."
    },
    {
      title: "Coffee Break Italian",
      level: "Beginner",
      cadence: "Short lessons",
      url: "https://coffeebreaklanguages.com/coffeebreakitalian/",
      why: "Compact lessons fit a daily holiday preparation routine.",
      mission: "Say the most useful line three times without looking."
    },
    {
      title: "ANSA",
      level: "Native",
      cadence: "Current Italian news",
      url: "https://www.ansa.it/",
      why: "Authentic headlines when learner audio begins to feel too tidy.",
      mission: "Catch place names, numbers and repeated nouns; do not chase every word."
    }
  ];

  window.PRONTO_DATA = {
    categories: categories,
    phrases: phrases,
    dailyPlan: dailyPlan,
    scenarios: scenarios,
    listeningResources: listeningResources
  };
}());
