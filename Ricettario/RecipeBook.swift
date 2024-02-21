//
//  RecipeBook.swift
//  Ricettario
//
//  Created by Gabriel Amore on 21/02/24.
//

import Foundation

var breakfastRecipes: [Recipe] = [
    
    Recipe(title: "Pancake allo sciroppo d'acero",
           ingredients: ["Fiocchi di avena 160 g",
                         "Latte intero 200 g",
                         "Acqua 160 g",
                         "Miele millefiori 1 cucchiaio",
                         "Sale fino q.b.",
                         "PER GUARNIRE",
                         "Yogurt bianco naturale 2 cucchiai",
                         "Fragole q.b.",
                         "Cioccolato fondente in scaglie q.b.",
                         "Sciroppo di acero q.b."],
           instructions: "Instructions 1", imageName: "pancake", description: "Deliziosi pancake con sciroppo d'acero, perfetti per una colazione golosa."),
    
    Recipe(title: "Muffin con gocce di cioccolato", ingredients: ["Ingredient 3", "Ingredient 4"], instructions: "Instructions 2", imageName: "muffin", description: "Semplici e sofficissime tortine che rapiranno il vostro olfatto già mentre le starete sfornando con il loro delizioso profumo."),
    Recipe(title: "Porridge", ingredients: ["Ingredient 5", "Ingredient 6"], instructions: "Instructions 3", imageName: "porridge", description: "Il porridge è la tipica ricetta della colazione all’inglese; facile e veloce: una zuppa di avena dolce per iniziare la giornata con la giusta carica di energia!"),
    Recipe(title: "Dorayaki", ingredients: ["Ingredient 7", "Ingredient 8"], instructions: "Instructions 4", imageName: "dorayaki", description: "Queste golose frittelline, realizzabili anche in versione mini, ricordano molto i pancakes americani, ma vengono preparati senza l'aggiunta di grassi e farciti a mò di panino. In Giappone si usa servirli ripieni di una salsa dolce a base di fagioli azuki."),
]

var lunchRecipes: [Recipe] = []
var dinnerRecipes: [Recipe] = []

var allRecipes: [[Recipe]] {
    [breakfastRecipes, lunchRecipes, dinnerRecipes]
}

var savedRecipes: [Recipe] = []
