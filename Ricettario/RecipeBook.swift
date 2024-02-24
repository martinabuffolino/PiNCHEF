//
//  RecipeBook.swift
//  Ricettario
//
//  Created by Gabriel Amore on 21/02/24.
//

import Foundation

var antipastiRecipes: [Recipe] = [
    Recipe(title: "Pancake allo sciroppo d'acero",
           ingredients: ["Fiocchi di avena : 160 g",
                         "Latte intero : 200 g",
                         "Acqua : 160 g",
                         "Miele millefiori : 1 cucchiaio",
                         "Sale fino : q.b.",
                         "PER GUARNIRE",
                         "Yogurt bianco naturale : 2 cucchiai",
                         "Fragole : q.b.",
                         "Cioccolato fondente in scaglie : q.b.",
                         "Sciroppo di acero : q.b."],
           instructions: "Instructions 1", imageName: "pancake", description: "Deliziosi pancake con sciroppo d'acero, perfetti per una colazione golosa.", isHeartRed : false),
    
    Recipe(title: "Muffin con gocce di cioccolato",
           ingredients: ["Burro (ammorbidito a temperatura ambiente) : 125 g",
                         "Farina 00 : 265 g",
                         "Zucchero : 135 g",
                         "Latte intero (a temperatura ambiente) : 135 g",
                         "Uova (circa 2 medie, a temperatura ambiente) : 110 g",
                         "Gocce di cioccolato fondente : 100 g",
                         "Baccello di vaniglia : 1",
                         "Bicarbonato raso : 1 cucchiaino",
                         "Sale fino : 1 pizzico",
                         "Lievito in polvere per dolci : 10 g"],
           instructions: "Instructions 2",
           imageName: "muffin",
           description: "Semplici e sofficissime tortine che rapiranno il vostro olfatto già mentre le starete sfornando con il loro delizioso profumo.", isHeartRed : false),
   
    Recipe(title: "Porridge",
           ingredients: ["Fiocchi di avena : 160 g",
                         "Latte intero : 200 g",
                         "Acqua : 160 g",
                         "Miele millefiori : 1 cucchiaio",
                         "Sale fino : q.b.",
                         "PER GUARNIRE",
                         "Yogurt bianco naturale : 2 cucchiai",
                         "Fragole : q.b.",
                         "Cioccolato fondente in scaglie : q.b.",
                         "Sciroppo di acero : q.b."],
           instructions: "Instructions 3",
           imageName: "porridge",
           description: "Il porridge è la tipica ricetta della colazione all’inglese; facile e veloce: una zuppa di avena dolce per iniziare la giornata con la giusta carica di energia!", isHeartRed : false),
    
    Recipe(title: "Dorayaki",
           ingredients: ["Acqua : 180 g",
                        "Farina 00 : 240 g",
                        "Zucchero a velo : 150 g",
                        "Uova : 2",
                        "Lievito in polvere per dolci : 3 g",
                        "Miele : 20 g",
                        "PER UNGERE LA PADELLA",
                        "Olio di semi : q.b."],
           instructions: "Instructions 4",
           imageName: "dorayaki",
           description: "Queste golose frittelline, realizzabili anche in versione mini, ricordano molto i pancakes americani, ma vengono preparati senza l'aggiunta di grassi e farciti a mò di panino. In Giappone si usa servirli ripieni di una salsa dolce a base di fagioli azuki.", isHeartRed : false),
    
    Recipe(title: "Croissant",
           ingredients: ["Farina 00 : 400 g",
                         "Farina Manitoba : 100 g",
                         "Acqua a temperatura ambiente : 250 g",
                         "Panna fresca liquida a temperatura ambiente : 50 g",
                         "Lievito di birra fresco : 10 g",
                         "Zucchero : 60 g",
                         "Sale fino : 12 g",
                         "Burro (morbido ma ancora plastico, di alta qualità) : 300 g",
                         "PER SPENNELLARE",
                         "Tuorli : 2",
                         "Latte intero : q.b."],
           instructions: "Instructions 4",
           imageName: "dorayaki",
           description: "Queste golose frittelline, realizzabili anche in versione mini, ricordano molto i pancakes americani, ma vengono preparati senza l'aggiunta di grassi e farciti a mò di panino. In Giappone si usa servirli ripieni di una salsa dolce a base di fagioli azuki.", isHeartRed : false),
]

var primiRecipes: [Recipe] = [
    Recipe(title: "Spaghetti alle vongole",
           ingredients: ["Spaghetti grossi : 320 g",
                         "Vongole : 1 kg",
                         "Aglio : 1 spicchio",
                         "Prezzemolo : 1 mazzetto",
                         "Olio extravergine d'oliva : q.b.",
                         "Pepe nero : q.b.",
                         "Sale fino : q.b.",
                         "Sale grosso per le vongole : q.b."],
           instructions: "Instructions 1", imageName: "spaghetti", description: "Direttamente dalla tradizione campana gli spaghetti alle vongole: un classico della cucina italiana e uno dei primi piatti di pasta più amati, replicati e interpretati.", isHeartRed : false),
    
    Recipe(title: "Gnocchi alla sorrentina",
           ingredients: ["PER GLI GNOCCHI",
                         "Patate rosse : 1 kg",
                         "Farina 00 : 300 g",
                         "Uova medio : 1",
                         "Sale fino : q.b.",
                         "Semola : q.b.",
                         "PER LA SALSA DI POMODORO",
                         "Passata di pomodoro : 600 g",
                         "Basilico : 6 foglie",
                         "Aglio : 1 spicchio",
                         "Olio extravergine d'oliva : q.b.",
                         "Sale fino : q.b.",
                         "PER CONDIRE",
                         "Mozzarella : 250 g",
                         "Parmigiano Reggiano DOP da grattugiare : 70 g"],
           instructions: "Instructions 2",
           imageName: "gnocchi",
           description: "Uno dei primi piatti campani più conosciuti in Italia e all’estero... sono gli gnocchi alla sorrentina, preparati davvero in tutti i ristoranti del mondo! Ciò che rende questo piatto di gnocchi così amato è il mix di sapori mediterranei, genuini e semplici.", isHeartRed : false),
   
    Recipe(title: "Orecchiette broccoli e salsiccia",
           ingredients: ["Orecchiette : 320 g",
                         "Broccoli : 300 g",
                         "Salsiccia : 300 g",
                         "Vino bianco : 40 g",
                         "Aglio : 1 spicchio",
                         "Timo : 2 rametti",
                         "Rosmarino : 1 rametto",
                         "Olio extravergine d'oliva : 30 g",
                         "Pepe nero : q.b.",
                         "Sale fino : q.b."],
           instructions: "Instructions 3",
           imageName: "orecchiette",
           description: "Il porridge è la tipica ricetta della colazione all’inglese; facile e veloce: una zuppa di avena dolce per iniziare la giornata con la giusta carica di energia!", isHeartRed : false),
    
    Recipe(title: "Pasta al forno",
           ingredients: ["Rigatoni : 600 g",
                         "Uova medie : 4",
                         "Parmigiano Reggiano DOP da grattugiare : 3 cucchiai",
                         "Scamorza (provola) : 300 g",
                         "PER LE POLPETTE",
                         "Carne di suino (macinato) : 250 g",
                         "Salsiccia : 150 g",
                         "Parmigiano Reggiano DOP da grattugiare : 100 g",
                         "Pane mollica : 100 g",
                         "Prezzemolo tritato : 2 cucchiai",
                         "Uova medie : 2",
                         "Sale fino : q.b.",
                         "Pepe nero : q.b.",
                         "Noce moscata : 1 pizzico",
                         "PER IL SUGO",
                         "Passata di pomodoro : 1 l",
                         "Cipolle bianche : 1",
                         "Aglio : 1 spicchio",
                         "Olio extravergine d'oliva : 4 cucchiai",
                         "Sale fino : q.b.",
                         "Basilico : 5 foglie",
                         "Pepe nero : q.b.",
                         "PER LA BESCIAMELLA",
                         "Latte intero : 1 l",
                         "Farina 00 : 80 g",
                         "Burro : 80 g",
                         "Sale fino : q.b.",
                         "Noce moscata : 1 pizzico"],
           instructions: "Instructions 4",
           imageName: "pastaforno",
           description: "La pasta al forno è il primo piatto domenicale per eccellenza. Gustosa e ricca, questa ricetta piacerà davvero a tutti", isHeartRed : false),
    
    Recipe(title: "Pasta e patate",
           ingredients: ["Pasta Mista : 320 g",
                         "Patate : 750 g",
                         "Sedano : 150 g",
                         "Carote : 150 g",
                         "Cipolle bianche : 1",
                         "Lardo : 130 g",
                         "Concentrato di pomodoro : 20 g",
                         "Rosmarino : 1 rametto",
                         "Parmigiano Reggiano DOP la crosta : 1",
                         "Olio extravergine d'oliva : q.b.",
                         "Sale fino : q.b.",
                         "Pepe nero : q.b."],
           instructions: "Instructions 4",
           imageName: "pastapatate",
           description: "Tipico primo piatto della tradizione popolare meridionale, la pasta e patate è una pietanza gustosa, calda e confortante che conquista tutti. Si tratta di una ricetta facile che si presta a molte variazioni; uno è però il segreto per renderla così cremosa: la pasta va cotta insieme alle patate.", isHeartRed : false),
]

var secondiRecipes: [Recipe] = [
    Recipe(title: "Calamari ripieni",
           ingredients: ["Fiocchi di avena : 160 g",
                         "Latte intero : 200 g",
                         "Acqua : 160 g",
                         "Miele millefiori : 1 cucchiaio",
                         "Sale fino : q.b.",
                         "PER GUARNIRE",
                         "Yogurt bianco naturale : 2 cucchiai",
                         "Fragole : q.b.",
                         "Cioccolato fondente in scaglie : q.b.",
                         "Sciroppo di acero : q.b."],
           instructions: "Instructions 1", imageName: "", description: "Deliziosi pancake con sciroppo d'acero, perfetti per una colazione golosa.", isHeartRed : false),
    
]

var dolciRecipes: [Recipe] = [
    Recipe(title: "Calamari ripieni",
           ingredients: [""],
           instructions: "Instructions 1", imageName: "", description: "Deliziosi pancake con sciroppo d'acero, perfetti per una colazione golosa.", isHeartRed : false),
    
    
]

// Unisci tutte le ricette in un'unica array
var allRecipes: [Recipe] = antipastiRecipes + primiRecipes + secondiRecipes + dolciRecipes

var savedRecipes: [Recipe] = []
