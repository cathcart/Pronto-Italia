import SwiftUI

enum LearningData {
    static let dailyPlan: [DailyPlanStep] = [
        DailyPlanStep(
            title: "Spaced review",
            minutes: 5,
            systemImage: "rectangle.stack.fill",
            method: "Spaced retrieval",
            instruction: "Recall older cards before new ones. Mark cards honestly so weak phrases return sooner.",
            tint: .italiaGreen
        ),
        DailyPlanStep(
            title: "Input flood",
            minutes: 4,
            systemImage: "ear.fill",
            method: "Input plus noticing",
            instruction: "Listen to a short cluster of related phrases and spot the same chunk in different contexts.",
            tint: .signalBlue
        ),
        DailyPlanStep(
            title: "Build the line",
            minutes: 3,
            systemImage: "text.insert",
            method: "Text reconstruction",
            instruction: "Put a useful sentence back together, then say it without looking.",
            tint: .sunset
        ),
        DailyPlanStep(
            title: "Say it aloud",
            minutes: 3,
            systemImage: "waveform",
            method: "Pushed output",
            instruction: "Answer one travel scenario out loud. Fluency grows when you reach for the phrase yourself.",
            tint: .tomato
        )
    ]

    static let phrases: [Phrase] = [
        Phrase(
            id: "travel-ticket-rome",
            category: .travel,
            italian: "Un biglietto per Roma, per favore.",
            english: "A ticket to Rome, please.",
            chunk: "per favore",
            note: "Use un biglietto for one ticket. Swap Roma for the town you need.",
            keywords: ["biglietto", "Roma", "favore"]
        ),
        Phrase(
            id: "travel-platform",
            category: .travel,
            italian: "Da quale binario parte il treno?",
            english: "Which platform does the train leave from?",
            chunk: "da quale binario",
            note: "Binario is the word to recognise in stations.",
            keywords: ["binario", "parte", "treno"]
        ),
        Phrase(
            id: "travel-time",
            category: .travel,
            italian: "A che ora parte?",
            english: "What time does it leave?",
            chunk: "a che ora",
            note: "A compact phrase for trains, buses, tours, and ferries.",
            keywords: ["ora", "parte"]
        ),
        Phrase(
            id: "travel-return",
            category: .travel,
            italian: "Andata e ritorno, per favore.",
            english: "Return ticket, please.",
            chunk: "andata e ritorno",
            note: "For one-way, say solo andata.",
            keywords: ["andata", "ritorno"]
        ),
        Phrase(
            id: "travel-delay",
            category: .travel,
            italian: "Il treno è in ritardo?",
            english: "Is the train delayed?",
            chunk: "in ritardo",
            note: "Useful on departure boards and announcements.",
            keywords: ["treno", "ritardo"]
        ),
        Phrase(
            id: "travel-taxi",
            category: .travel,
            italian: "Vorrei prendere un taxi.",
            english: "I would like to take a taxi.",
            chunk: "vorrei prendere",
            note: "Vorrei is the polite workhorse: I would like.",
            keywords: ["vorrei", "prendere", "taxi"]
        ),
        Phrase(
            id: "travel-stop-here",
            category: .travel,
            italian: "Può fermarsi qui?",
            english: "Can you stop here?",
            chunk: "può",
            note: "Può is a polite way to ask can you.",
            keywords: ["può", "fermarsi", "qui"]
        ),
        Phrase(
            id: "food-table",
            category: .food,
            italian: "Un tavolo per due, per favore.",
            english: "A table for two, please.",
            chunk: "per due",
            note: "Swap due for your party size.",
            keywords: ["tavolo", "due", "favore"]
        ),
        Phrase(
            id: "food-menu",
            category: .food,
            italian: "Posso vedere il menù?",
            english: "Can I see the menu?",
            chunk: "posso vedere",
            note: "Posso is can I.",
            keywords: ["posso", "vedere", "menù"]
        ),
        Phrase(
            id: "food-recommend",
            category: .food,
            italian: "Che cosa mi consiglia?",
            english: "What do you recommend?",
            chunk: "mi consiglia",
            note: "A high-value restaurant phrase that invites local advice.",
            keywords: ["cosa", "consiglia"]
        ),
        Phrase(
            id: "food-order",
            category: .food,
            italian: "Vorrei ordinare questo.",
            english: "I would like to order this.",
            chunk: "vorrei ordinare",
            note: "Pointing and questo solve many menu moments.",
            keywords: ["vorrei", "ordinare", "questo"]
        ),
        Phrase(
            id: "food-water",
            category: .food,
            italian: "Acqua naturale o frizzante?",
            english: "Still or sparkling water?",
            chunk: "naturale o frizzante",
            note: "You will hear this often after sitting down.",
            keywords: ["acqua", "naturale", "frizzante"]
        ),
        Phrase(
            id: "food-vegetarian",
            category: .food,
            italian: "Sono vegetariano.",
            english: "I am vegetarian.",
            chunk: "sono",
            note: "Use vegetariana if you want feminine agreement.",
            keywords: ["sono", "vegetariano"]
        ),
        Phrase(
            id: "food-gluten",
            category: .food,
            italian: "Avete qualcosa senza glutine?",
            english: "Do you have anything gluten-free?",
            chunk: "senza glutine",
            note: "Senza means without.",
            keywords: ["avete", "senza", "glutine"]
        ),
        Phrase(
            id: "food-bill",
            category: .food,
            italian: "Il conto, per favore.",
            english: "The bill, please.",
            chunk: "il conto",
            note: "Short, polite, and essential.",
            keywords: ["conto", "favore"]
        ),
        Phrase(
            id: "food-menu-antipasti",
            category: .food,
            italian: "Antipasti",
            english: "Starters or appetisers.",
            chunk: "anti",
            note: "Often small plates before pasta or a main course.",
            keywords: ["antipasti", "starters", "appetisers"]
        ),
        Phrase(
            id: "food-menu-primi",
            category: .food,
            italian: "Primi piatti",
            english: "First courses, usually pasta, risotto, soup, or gnocchi.",
            chunk: "primi",
            note: "Primi are normally not the main meat or fish course.",
            keywords: ["primi", "piatti", "pasta", "risotto", "gnocchi"]
        ),
        Phrase(
            id: "food-menu-secondi",
            category: .food,
            italian: "Secondi piatti",
            english: "Second courses, usually meat, fish, or a main protein.",
            chunk: "secondi",
            note: "Side dishes often need to be ordered separately.",
            keywords: ["secondi", "piatti", "meat", "fish"]
        ),
        Phrase(
            id: "food-menu-contorni",
            category: .food,
            italian: "Contorni",
            english: "Side dishes.",
            chunk: "contorni",
            note: "Look here for vegetables, potatoes, salad, and sides.",
            keywords: ["contorni", "side", "vegetables"]
        ),
        Phrase(
            id: "food-menu-dolci",
            category: .food,
            italian: "Dolci",
            english: "Desserts.",
            chunk: "dolci",
            note: "You may also see dessert listed as dessert or dolce.",
            keywords: ["dolci", "dessert"]
        ),
        Phrase(
            id: "food-menu-coperto",
            category: .food,
            italian: "Coperto",
            english: "Cover charge.",
            chunk: "coperto",
            note: "A per-person table charge that can appear on the bill.",
            keywords: ["coperto", "charge", "bill"]
        ),
        Phrase(
            id: "food-menu-service",
            category: .food,
            italian: "Servizio incluso",
            english: "Service included.",
            chunk: "servizio",
            note: "Useful to recognise before adding an extra tip.",
            keywords: ["servizio", "incluso", "tip"]
        ),
        Phrase(
            id: "food-menu-dish-day",
            category: .food,
            italian: "Qual è il piatto del giorno?",
            english: "What is the dish of the day?",
            chunk: "piatto del giorno",
            note: "A good way to ask about a fresh or daily special.",
            keywords: ["piatto", "giorno", "special"]
        ),
        Phrase(
            id: "food-menu-al-forno",
            category: .food,
            italian: "Al forno",
            english: "Baked or oven-cooked.",
            chunk: "forno",
            note: "You will see this with pasta, vegetables, fish, or potatoes.",
            keywords: ["forno", "baked", "oven"]
        ),
        Phrase(
            id: "food-menu-alla-griglia",
            category: .food,
            italian: "Alla griglia",
            english: "Grilled.",
            chunk: "griglia",
            note: "Common with fish, steak, vegetables, and chicken.",
            keywords: ["griglia", "grilled"]
        ),
        Phrase(
            id: "food-menu-fritto",
            category: .food,
            italian: "Fritto",
            english: "Fried.",
            chunk: "fritto",
            note: "Fritto misto is mixed fried seafood or vegetables.",
            keywords: ["fritto", "fried"]
        ),
        Phrase(
            id: "food-menu-crudo",
            category: .food,
            italian: "Crudo",
            english: "Raw or cured.",
            chunk: "crudo",
            note: "Often appears with fish, seafood, ham, or carpaccio.",
            keywords: ["crudo", "raw", "cured"]
        ),
        Phrase(
            id: "food-menu-affumicato",
            category: .food,
            italian: "Affumicato",
            english: "Smoked.",
            chunk: "affumicato",
            note: "Useful for fish, cheese, and cured meat descriptions.",
            keywords: ["affumicato", "smoked"]
        ),
        Phrase(
            id: "food-menu-piccante",
            category: .food,
            italian: "È piccante?",
            english: "Is it spicy?",
            chunk: "piccante",
            note: "A compact question before ordering.",
            keywords: ["piccante", "spicy"]
        ),
        Phrase(
            id: "food-menu-pomodoro",
            category: .food,
            italian: "Al pomodoro",
            english: "With tomato sauce.",
            chunk: "pomodoro",
            note: "A very common pasta and sauce word.",
            keywords: ["pomodoro", "tomato"]
        ),
        Phrase(
            id: "food-menu-funghi",
            category: .food,
            italian: "Ai funghi",
            english: "With mushrooms.",
            chunk: "funghi",
            note: "Funghi can appear with pasta, pizza, risotto, or meat.",
            keywords: ["funghi", "mushrooms"]
        ),
        Phrase(
            id: "food-menu-porcini",
            category: .food,
            italian: "Funghi porcini",
            english: "Porcini mushrooms.",
            chunk: "porcini",
            note: "A prized mushroom often found with pasta, risotto, or meat.",
            keywords: ["funghi", "porcini", "mushrooms"]
        ),
        Phrase(
            id: "food-menu-champignon",
            category: .food,
            italian: "Champignon",
            english: "Button mushrooms.",
            chunk: "champignon",
            note: "Often used for common cultivated mushrooms.",
            keywords: ["champignon", "mushrooms"]
        ),
        Phrase(
            id: "food-menu-tartufo",
            category: .food,
            italian: "Al tartufo",
            english: "With truffle.",
            chunk: "tartufo",
            note: "Often found in pasta, risotto, eggs, and sauces.",
            keywords: ["tartufo", "truffle"]
        ),
        Phrase(
            id: "food-menu-frutti-mare",
            category: .food,
            italian: "Frutti di mare",
            english: "Seafood.",
            chunk: "mare",
            note: "Literally fruits of the sea.",
            keywords: ["frutti", "mare", "seafood"]
        ),
        Phrase(
            id: "food-menu-cozze",
            category: .food,
            italian: "Cozze",
            english: "Mussels.",
            chunk: "cozze",
            note: "Useful for seafood pasta and starters.",
            keywords: ["cozze", "mussels"]
        ),
        Phrase(
            id: "food-menu-vongole",
            category: .food,
            italian: "Vongole",
            english: "Clams.",
            chunk: "vongole",
            note: "Spaghetti alle vongole is a classic menu item.",
            keywords: ["vongole", "clams"]
        ),
        Phrase(
            id: "food-menu-gamberi",
            category: .food,
            italian: "Gamberi",
            english: "Prawns or shrimp.",
            chunk: "gamberi",
            note: "Look for gamberi in pasta, salads, and seafood dishes.",
            keywords: ["gamberi", "prawns", "shrimp"]
        ),
        Phrase(
            id: "food-menu-pesce-giorno",
            category: .food,
            italian: "Pesce del giorno",
            english: "Fish of the day.",
            chunk: "pesce",
            note: "Ask how it is cooked if the menu is brief.",
            keywords: ["pesce", "giorno", "fish"]
        ),
        Phrase(
            id: "food-menu-branzino",
            category: .food,
            italian: "Branzino",
            english: "Sea bass.",
            chunk: "branzino",
            note: "A common whole fish or fillet on dinner menus.",
            keywords: ["branzino", "bass", "fish"]
        ),
        Phrase(
            id: "food-menu-orata",
            category: .food,
            italian: "Orata",
            english: "Sea bream.",
            chunk: "orata",
            note: "Common grilled or baked.",
            keywords: ["orata", "bream", "fish"]
        ),
        Phrase(
            id: "food-menu-bistecca",
            category: .food,
            italian: "Bistecca",
            english: "Steak.",
            chunk: "bistecca",
            note: "Bistecca alla fiorentina is a famous Tuscan steak.",
            keywords: ["bistecca", "steak"]
        ),
        Phrase(
            id: "food-menu-pollo",
            category: .food,
            italian: "Pollo",
            english: "Chicken.",
            chunk: "pollo",
            note: "A simple high-frequency meat word.",
            keywords: ["pollo", "chicken"]
        ),
        Phrase(
            id: "food-menu-maiale",
            category: .food,
            italian: "Maiale",
            english: "Pork.",
            chunk: "maiale",
            note: "Useful if you avoid pork.",
            keywords: ["maiale", "pork"]
        ),
        Phrase(
            id: "food-menu-agnello",
            category: .food,
            italian: "Agnello",
            english: "Lamb.",
            chunk: "agnello",
            note: "Often roasted, grilled, or served as chops.",
            keywords: ["agnello", "lamb"]
        ),
        Phrase(
            id: "food-menu-risotto",
            category: .food,
            italian: "Risotto",
            english: "Creamy rice dish.",
            chunk: "risotto",
            note: "Often a primo, not a side dish.",
            keywords: ["risotto", "rice"]
        ),
        Phrase(
            id: "food-menu-gnocchi",
            category: .food,
            italian: "Gnocchi",
            english: "Small potato dumplings.",
            chunk: "gnocchi",
            note: "Usually served as a first course with sauce.",
            keywords: ["gnocchi", "dumplings"]
        ),
        Phrase(
            id: "food-menu-ravioli",
            category: .food,
            italian: "Ravioli",
            english: "Stuffed pasta parcels.",
            chunk: "ravioli",
            note: "Often filled with ricotta, spinach, meat, or pumpkin.",
            keywords: ["ravioli", "stuffed", "pasta"]
        ),
        Phrase(
            id: "food-menu-uovo",
            category: .food,
            italian: "Uovo",
            english: "Egg.",
            chunk: "uovo",
            note: "Singular egg. The plural is uova.",
            keywords: ["uovo", "egg"]
        ),
        Phrase(
            id: "food-menu-uova",
            category: .food,
            italian: "Uova",
            english: "Eggs.",
            chunk: "uova",
            note: "Common in pasta dough, carbonara, frittata, desserts, and sauces.",
            keywords: ["uova", "eggs"]
        ),
        Phrase(
            id: "food-menu-frittata",
            category: .food,
            italian: "Frittata",
            english: "Italian omelette.",
            chunk: "frittata",
            note: "A clear sign that eggs are central to the dish.",
            keywords: ["frittata", "egg", "omelette"]
        ),
        Phrase(
            id: "food-menu-carbonara",
            category: .food,
            italian: "Alla carbonara",
            english: "With egg, cheese, pepper, and cured pork.",
            chunk: "carbonara",
            note: "Carbonara sauce traditionally contains egg.",
            keywords: ["carbonara", "uova", "egg", "pork"]
        ),
        Phrase(
            id: "food-menu-tagliatelle-ragu",
            category: .food,
            italian: "Tagliatelle al ragù",
            english: "Ribbon pasta with meat sauce.",
            chunk: "ragù",
            note: "Ragù usually means a slow-cooked meat sauce.",
            keywords: ["tagliatelle", "ragù", "meat", "sauce"]
        ),
        Phrase(
            id: "food-menu-tiramisu",
            category: .food,
            italian: "Tiramisù",
            english: "Coffee and mascarpone dessert.",
            chunk: "tiramisù",
            note: "One of the most recognisable Italian desserts.",
            keywords: ["tiramisù", "dessert", "coffee"]
        ),
        Phrase(
            id: "food-menu-panna-cotta",
            category: .food,
            italian: "Panna cotta",
            english: "Set cream dessert.",
            chunk: "panna",
            note: "Panna means cream.",
            keywords: ["panna", "cotta", "cream", "dessert"]
        ),
        Phrase(
            id: "food-menu-fragole",
            category: .food,
            italian: "Fragole",
            english: "Strawberries.",
            chunk: "fragole",
            note: "The singular is fragola.",
            keywords: ["fragole", "strawberries"]
        ),
        Phrase(
            id: "food-menu-fragola",
            category: .food,
            italian: "Alla fragola",
            english: "Strawberry-flavoured or with strawberry.",
            chunk: "fragola",
            note: "Common for gelato, desserts, yoghurt, and sauces.",
            keywords: ["fragola", "strawberry", "gelato"]
        ),
        Phrase(
            id: "food-menu-fragole-panna",
            category: .food,
            italian: "Fragole con panna",
            english: "Strawberries with cream.",
            chunk: "con panna",
            note: "A simple dessert phrase that often appears in season.",
            keywords: ["fragole", "panna", "strawberries", "cream"]
        ),
        Phrase(
            id: "food-menu-crostata-fragole",
            category: .food,
            italian: "Crostata alle fragole",
            english: "Strawberry tart.",
            chunk: "alle fragole",
            note: "Crostata is a tart or jam tart style dessert.",
            keywords: ["crostata", "fragole", "tart", "strawberry"]
        ),
        Phrase(
            id: "food-menu-vino-casa",
            category: .food,
            italian: "Vino della casa",
            english: "House wine.",
            chunk: "vino",
            note: "Often available by glass, carafe, half litre, or litre.",
            keywords: ["vino", "casa", "wine"]
        ),
        Phrase(
            id: "food-menu-contains-nuts",
            category: .food,
            italian: "Contiene noci?",
            english: "Does it contain nuts?",
            chunk: "contiene",
            note: "Contiene means contains.",
            keywords: ["contiene", "noci", "nuts"]
        ),
        Phrase(
            id: "food-menu-contains-eggs",
            category: .food,
            italian: "Contiene uova?",
            english: "Does it contain eggs?",
            chunk: "contiene",
            note: "Useful for checking pasta, sauces, desserts, and fried coatings.",
            keywords: ["contiene", "uova", "eggs"]
        ),
        Phrase(
            id: "food-menu-egg-free",
            category: .food,
            italian: "Senza uova",
            english: "Egg-free.",
            chunk: "senza",
            note: "Senza means without.",
            keywords: ["senza", "uova", "egg-free"]
        ),
        Phrase(
            id: "food-menu-dairy-free",
            category: .food,
            italian: "Senza latticini",
            english: "Dairy-free.",
            chunk: "senza",
            note: "Useful for recognising or requesting no dairy.",
            keywords: ["senza", "latticini", "dairy"]
        ),
        Phrase(
            id: "money-cost",
            category: .money,
            italian: "Quanto costa?",
            english: "How much does it cost?",
            chunk: "quanto costa",
            note: "Probably your most useful money question.",
            keywords: ["quanto", "costa"]
        ),
        Phrase(
            id: "money-card",
            category: .money,
            italian: "Posso pagare con carta?",
            english: "Can I pay by card?",
            chunk: "pagare con carta",
            note: "Carta can mean card in this context.",
            keywords: ["pagare", "carta"]
        ),
        Phrase(
            id: "money-cash",
            category: .money,
            italian: "Accettate contanti?",
            english: "Do you accept cash?",
            chunk: "accettate",
            note: "Contanti is cash.",
            keywords: ["accettate", "contanti"]
        ),
        Phrase(
            id: "money-atm",
            category: .money,
            italian: "Dov'è un bancomat?",
            english: "Where is an ATM?",
            chunk: "dov'è",
            note: "Bancomat is the common word for ATM.",
            keywords: ["dov'è", "bancomat"]
        ),
        Phrase(
            id: "money-receipt",
            category: .money,
            italian: "Posso avere lo scontrino?",
            english: "Can I have the receipt?",
            chunk: "posso avere",
            note: "Useful after small purchases.",
            keywords: ["posso", "avere", "scontrino"]
        ),
        Phrase(
            id: "money-cheaper",
            category: .money,
            italian: "Avete qualcosa di più economico?",
            english: "Do you have something cheaper?",
            chunk: "più economico",
            note: "Polite enough for markets and shops.",
            keywords: ["avete", "economico"]
        ),
        Phrase(
            id: "hotel-reservation",
            category: .hotel,
            italian: "Ho una prenotazione.",
            english: "I have a reservation.",
            chunk: "ho una",
            note: "Say this at reception before giving your name.",
            keywords: ["ho", "prenotazione"]
        ),
        Phrase(
            id: "hotel-name",
            category: .hotel,
            italian: "La prenotazione è a nome di Cathcart.",
            english: "The reservation is under the name Cathcart.",
            chunk: "a nome di",
            note: "Replace the name with yours.",
            keywords: ["prenotazione", "nome"]
        ),
        Phrase(
            id: "hotel-checkout",
            category: .hotel,
            italian: "A che ora è il check-out?",
            english: "What time is check-out?",
            chunk: "a che ora",
            note: "Works for breakfast times too.",
            keywords: ["ora", "check-out"]
        ),
        Phrase(
            id: "hotel-breakfast",
            category: .hotel,
            italian: "La colazione è inclusa?",
            english: "Is breakfast included?",
            chunk: "è inclusa",
            note: "Colazione is breakfast.",
            keywords: ["colazione", "inclusa"]
        ),
        Phrase(
            id: "hotel-ac",
            category: .hotel,
            italian: "C'è l'aria condizionata?",
            english: "Is there air conditioning?",
            chunk: "c'è",
            note: "A summer survival phrase.",
            keywords: ["aria", "condizionata"]
        ),
        Phrase(
            id: "hotel-key",
            category: .hotel,
            italian: "Ho perso la chiave.",
            english: "I lost the key.",
            chunk: "ho perso",
            note: "For key cards, carta della camera may also appear.",
            keywords: ["perso", "chiave"]
        ),
        Phrase(
            id: "directions-excuse",
            category: .directions,
            italian: "Mi scusi, dov'è la stazione?",
            english: "Excuse me, where is the station?",
            chunk: "mi scusi",
            note: "Mi scusi is the polite opener with strangers.",
            keywords: ["scusi", "dov'è", "stazione"]
        ),
        Phrase(
            id: "directions-left",
            category: .directions,
            italian: "Giri a sinistra.",
            english: "Turn left.",
            chunk: "a sinistra",
            note: "You will hear this in directions.",
            keywords: ["giri", "sinistra"]
        ),
        Phrase(
            id: "directions-right",
            category: .directions,
            italian: "Giri a destra.",
            english: "Turn right.",
            chunk: "a destra",
            note: "Pair destra with right.",
            keywords: ["giri", "destra"]
        ),
        Phrase(
            id: "directions-straight",
            category: .directions,
            italian: "Vada sempre dritto.",
            english: "Go straight ahead.",
            chunk: "sempre dritto",
            note: "Sempre dritto is common in spoken directions.",
            keywords: ["vada", "dritto"]
        ),
        Phrase(
            id: "directions-near",
            category: .directions,
            italian: "È vicino o lontano?",
            english: "Is it near or far?",
            chunk: "vicino o lontano",
            note: "Good for deciding whether to walk.",
            keywords: ["vicino", "lontano"]
        ),
        Phrase(
            id: "directions-map",
            category: .directions,
            italian: "Può indicarmelo sulla mappa?",
            english: "Can you show it to me on the map?",
            chunk: "sulla mappa",
            note: "Useful when speech gets too fast.",
            keywords: ["può", "mappa"]
        ),
        Phrase(
            id: "social-hello",
            category: .social,
            italian: "Buongiorno.",
            english: "Good morning or good day.",
            chunk: "buon",
            note: "A safe greeting in shops, hotels, and cafes.",
            keywords: ["buongiorno"]
        ),
        Phrase(
            id: "social-thanks",
            category: .social,
            italian: "Grazie mille.",
            english: "Thanks a lot.",
            chunk: "mille",
            note: "A warmer thank you than grazie.",
            keywords: ["grazie", "mille"]
        ),
        Phrase(
            id: "social-slowly",
            category: .social,
            italian: "Può parlare più lentamente?",
            english: "Can you speak more slowly?",
            chunk: "più lentamente",
            note: "One of the best learner rescue lines.",
            keywords: ["parlare", "lentamente"]
        ),
        Phrase(
            id: "social-repeat",
            category: .social,
            italian: "Può ripetere, per favore?",
            english: "Can you repeat that, please?",
            chunk: "può ripetere",
            note: "Use this before switching to English.",
            keywords: ["ripetere", "favore"]
        ),
        Phrase(
            id: "social-learning",
            category: .social,
            italian: "Sto imparando l'italiano.",
            english: "I am learning Italian.",
            chunk: "sto imparando",
            note: "Often earns patience and a smile.",
            keywords: ["imparando", "italiano"]
        ),
        Phrase(
            id: "social-english",
            category: .social,
            italian: "Parla inglese?",
            english: "Do you speak English?",
            chunk: "parla",
            note: "Polite and direct.",
            keywords: ["parla", "inglese"]
        ),
        Phrase(
            id: "emergency-help",
            category: .emergency,
            italian: "Aiuto!",
            english: "Help!",
            chunk: "aiuto",
            note: "Recognise this even if you hope not to use it.",
            keywords: ["aiuto"]
        ),
        Phrase(
            id: "emergency-doctor",
            category: .emergency,
            italian: "Ho bisogno di un medico.",
            english: "I need a doctor.",
            chunk: "ho bisogno di",
            note: "Bisogno means need.",
            keywords: ["bisogno", "medico"]
        ),
        Phrase(
            id: "emergency-pharmacy",
            category: .emergency,
            italian: "Dov'è la farmacia più vicina?",
            english: "Where is the nearest pharmacy?",
            chunk: "più vicina",
            note: "Farmacia signs are useful landmarks too.",
            keywords: ["farmacia", "vicina"]
        ),
        Phrase(
            id: "emergency-allergy",
            category: .emergency,
            italian: "Sono allergico alle noci.",
            english: "I am allergic to nuts.",
            chunk: "sono allergico",
            note: "Use allergica for feminine agreement.",
            keywords: ["allergico", "noci"]
        ),
        Phrase(
            id: "emergency-lost",
            category: .emergency,
            italian: "Mi sono perso.",
            english: "I am lost.",
            chunk: "mi sono perso",
            note: "Use persa for feminine agreement.",
            keywords: ["perso"]
        ),
        Phrase(
            id: "emergency-police",
            category: .emergency,
            italian: "Chiami la polizia, per favore.",
            english: "Call the police, please.",
            chunk: "chiami",
            note: "A direct imperative for urgent situations.",
            keywords: ["chiami", "polizia"]
        )
    ]

    static let scenarios: [TravelScenario] = [
        TravelScenario(
            title: "At the station",
            setting: "Ticket office",
            goal: "Buy the right ticket and recognise platform information.",
            systemImage: "tram.fill",
            focusChunks: ["un biglietto", "a che ora", "da quale binario", "in ritardo"],
            phrases: phrases(with: ["travel-ticket-rome", "travel-platform", "travel-time", "travel-return", "travel-delay"]),
            questions: [
                PracticeQuestion(
                    prompt: "You hear: Da quale binario parte il treno?",
                    options: ["Which platform?", "How much?", "Where is the hotel?"],
                    answer: "Which platform?",
                    explanation: "Binario is the key station word for platform."
                ),
                PracticeQuestion(
                    prompt: "The board says in ritardo.",
                    options: ["Delayed", "Cancelled", "On the left"],
                    answer: "Delayed",
                    explanation: "In ritardo means delayed or late."
                )
            ],
            reconstruction: ReconstructionExercise(
                englishPrompt: "A ticket to Rome, please.",
                target: "Un biglietto per Roma, per favore.",
                words: ["Un", "biglietto", "per", "Roma", "per", "favore."]
            ),
            outputPrompt: "Ask for a return ticket, then ask what time the train leaves."
        ),
        TravelScenario(
            title: "Dinner booking",
            setting: "Restaurant",
            goal: "Get a table, understand water choices, and ask for the bill.",
            systemImage: "fork.knife",
            focusChunks: ["un tavolo", "mi consiglia", "senza glutine", "il conto"],
            phrases: phrases(with: ["food-table", "food-menu", "food-recommend", "food-water", "food-bill", "food-gluten"]),
            questions: [
                PracticeQuestion(
                    prompt: "The waiter asks: Acqua naturale o frizzante?",
                    options: ["Still or sparkling water?", "Cash or card?", "Inside or outside?"],
                    answer: "Still or sparkling water?",
                    explanation: "Naturale is still water; frizzante is sparkling."
                ),
                PracticeQuestion(
                    prompt: "You want a recommendation.",
                    options: ["Che cosa mi consiglia?", "Dov'è la farmacia?", "A che ora parte?"],
                    answer: "Che cosa mi consiglia?",
                    explanation: "Mi consiglia invites the other person to recommend something."
                )
            ],
            reconstruction: ReconstructionExercise(
                englishPrompt: "The bill, please.",
                target: "Il conto, per favore.",
                words: ["Il", "conto,", "per", "favore."]
            ),
            outputPrompt: "Ask for a table for two, choose sparkling water, and ask for the bill."
        ),
        TravelScenario(
            title: "Reading the menu",
            setting: "Trattoria menu",
            goal: "Decode courses, cooking styles, seafood, meat, and dessert before ordering.",
            systemImage: "list.bullet.rectangle.fill",
            focusChunks: ["primi piatti", "secondi piatti", "alla griglia", "frutti di mare", "piatto del giorno"],
            phrases: phrases(with: [
                "food-menu-antipasti",
                "food-menu-primi",
                "food-menu-secondi",
                "food-menu-contorni",
                "food-menu-funghi",
                "food-menu-uova",
                "food-menu-alla-griglia",
                "food-menu-frutti-mare",
                "food-menu-pesce-giorno",
                "food-menu-fragole",
                "food-menu-tiramisu",
                "food-menu-coperto"
            ]),
            questions: [
                PracticeQuestion(
                    prompt: "On the menu you see contorni.",
                    options: ["Side dishes", "Desserts", "Service included"],
                    answer: "Side dishes",
                    explanation: "Contorni are side dishes such as vegetables, potatoes, or salad."
                ),
                PracticeQuestion(
                    prompt: "A fish dish is described as alla griglia.",
                    options: ["Grilled", "Fried", "Raw"],
                    answer: "Grilled",
                    explanation: "Alla griglia means grilled."
                )
            ],
            reconstruction: ReconstructionExercise(
                englishPrompt: "What is the dish of the day?",
                target: "Qual è il piatto del giorno?",
                words: ["Qual", "è", "il", "piatto", "del", "giorno?"]
            ),
            outputPrompt: "Ask what the dish of the day is, then ask whether a dish contains nuts."
        ),
        TravelScenario(
            title: "Finding your way",
            setting: "Street corner",
            goal: "Ask for directions and recognise the answer.",
            systemImage: "map.fill",
            focusChunks: ["mi scusi", "a sinistra", "a destra", "sempre dritto"],
            phrases: phrases(with: ["directions-excuse", "directions-left", "directions-right", "directions-straight", "directions-near", "directions-map"]),
            questions: [
                PracticeQuestion(
                    prompt: "Someone says: Giri a destra.",
                    options: ["Turn right", "Turn left", "Go straight"],
                    answer: "Turn right",
                    explanation: "Destra is right; sinistra is left."
                ),
                PracticeQuestion(
                    prompt: "You want them to point to the place.",
                    options: ["Può indicarmelo sulla mappa?", "Posso pagare con carta?", "Ho una prenotazione."],
                    answer: "Può indicarmelo sulla mappa?",
                    explanation: "Sulla mappa means on the map."
                )
            ],
            reconstruction: ReconstructionExercise(
                englishPrompt: "Excuse me, where is the station?",
                target: "Mi scusi, dov'è la stazione?",
                words: ["Mi", "scusi,", "dov'è", "la", "stazione?"]
            ),
            outputPrompt: "Ask where the station is, then ask if it is near or far."
        ),
        TravelScenario(
            title: "Checking in",
            setting: "Hotel reception",
            goal: "Check in and ask the practical questions that matter.",
            systemImage: "bed.double.fill",
            focusChunks: ["ho una prenotazione", "a nome di", "è inclusa", "c'è"],
            phrases: phrases(with: ["hotel-reservation", "hotel-name", "hotel-checkout", "hotel-breakfast", "hotel-ac", "hotel-key"]),
            questions: [
                PracticeQuestion(
                    prompt: "Reception asks for a nome di.",
                    options: ["The name on the booking", "Your room key", "The breakfast time"],
                    answer: "The name on the booking",
                    explanation: "A nome di means under the name of."
                ),
                PracticeQuestion(
                    prompt: "You want to ask if breakfast is included.",
                    options: ["La colazione è inclusa?", "Il treno è in ritardo?", "Accettate contanti?"],
                    answer: "La colazione è inclusa?",
                    explanation: "Colazione is breakfast and inclusa means included."
                )
            ],
            reconstruction: ReconstructionExercise(
                englishPrompt: "I have a reservation.",
                target: "Ho una prenotazione.",
                words: ["Ho", "una", "prenotazione."]
            ),
            outputPrompt: "Say you have a reservation, give the name, and ask about check-out."
        )
    ]

    static let listeningResources: [ListeningResource] = [
        ListeningResource(
            title: "Podcast Italiano Principiante",
            level: "Beginner",
            cadence: "Updated weekly",
            url: "https://podcasts.apple.com/us/podcast/podcast-italiano-principiante-learn-italian-beginners/id1756726796",
            systemImage: "person.wave.2.fill",
            whyItHelps: "Slow, natural Italian with beginner stories and guided listening.",
            mission: "Listen once for gist, then replay and write five words you recognise."
        ),
        ListeningResource(
            title: "News in Slow Italian",
            level: "Beginner to intermediate",
            cadence: "Weekly news program",
            url: "https://www.newsinslowitalian.com/home/news",
            systemImage: "newspaper.fill",
            whyItHelps: "Current events in plain language, useful for high-frequency words beyond travel.",
            mission: "Pick one short headline and underline every word that looks familiar."
        ),
        ListeningResource(
            title: "Italiano ON-Air",
            level: "Beginner to intermediate",
            cadence: "Weekly with transcript",
            url: "https://podcast.scuolaleonardo.com/",
            systemImage: "doc.text.magnifyingglass",
            whyItHelps: "Episodes include transcripts for vocabulary, expressions, idioms, listening, and pronunciation.",
            mission: "Read the transcript after listening and circle one phrase you could reuse on holiday."
        ),
        ListeningResource(
            title: "Coffee Break Italian",
            level: "Beginner",
            cadence: "Short lesson seasons",
            url: "https://podcasts.apple.com/us/podcast/coffee-break-italian/id958179457",
            systemImage: "cup.and.saucer.fill",
            whyItHelps: "Fifteen-minute lessons are a good match for daily microlearning.",
            mission: "After one lesson, say the most useful line aloud three times from memory."
        ),
        ListeningResource(
            title: "Italy Made Easy Podcast",
            level: "Intermediate-friendly",
            cadence: "Slow Italian archive",
            url: "https://italymadeeasy.com/podcast-2/",
            systemImage: "waveform.circle.fill",
            whyItHelps: "Designed for listening comprehension in slower Italian.",
            mission: "Use it as input flood: choose one topic and collect recurring words."
        ),
        ListeningResource(
            title: "ANSA Voice",
            level: "Native",
            cadence: "Current Italian news podcasts",
            url: "https://www.ansa.it/sito/podcast/index.shtml",
            systemImage: "radio.fill",
            whyItHelps: "Authentic headlines and daily news once learner audio feels too tidy.",
            mission: "Do not aim for full comprehension. Catch place names, numbers, and repeated nouns."
        )
    ]

    static func phrases(in category: PhraseCategory?) -> [Phrase] {
        guard let category else { return phrases }
        return phrases.filter { $0.category == category }
    }

    private static func phrase(_ id: String) -> Phrase {
        guard let phrase = phrases.first(where: { $0.id == id }) else {
            preconditionFailure("Missing phrase with id \(id)")
        }
        return phrase
    }

    private static func phrases(with ids: [String]) -> [Phrase] {
        ids.map(phrase)
    }
}
