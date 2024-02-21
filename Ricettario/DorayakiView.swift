//
//  DorayakiView.swift
//  Ricettario
//
//  Created by Martina Buffolino on 19/02/24.
//

import Foundation
import SwiftUI

struct DorayakiView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var stepIndex = 0
    
    // Aggiungi un parametro per gli ingredienti
    let ingredients: [String] = [
        "Fiocchi di avena 160 g",
        "Latte intero 200 g",
        "Acqua 160 g",
        "Miele millefiori 1 cucchiaio",
        "Sale fino q.b.",
        "PER GUARNIRE",
        "Yogurt bianco naturale 2 cucchiai",
        "Fragole q.b.",
        "Cioccolato fondente in scaglie q.b.",
        "Sciroppo di acero q.b."
    ]
    
    var preparationSteps: [String] = [
//        Versare la farina in una ciotola.
//        Aggiungere lo zucchero a velo e il lievito per dolci.
//        Aggiunta degli Ingredienti Liquidi:
//        Unire le uova, il miele e l'acqua a temperatura ambiente al composto nella ciotola.
//        Mescolare il Composto:
//        Sbattere il composto con una frusta, iniziando lentamente e poi energicamente, fino a ottenere una consistenza fluida senza grumi.
//        Riscaldare la Padella e Versare l'Impasto:
//        Scaldare una padella per crepes o una padella antiaderente ampia.
//        Versare un filo d'olio e distribuirlo sulla superficie con un foglio di carta da cucina.
//        Versare un mestolo di composto per ogni dorayaki sulla padella.
//        Cottura dei Dorayaki:
//        Cuocere a fuoco medio per circa 3 minuti.
//        Girare i dorayaki non appena iniziano a formarsi delle piccole bollicine sulla superficie.
//        Continuare la cottura per 1 minuto anche dall'altro lato.
//        Ripetere il processo fino a terminare l'impasto.
//        Servire i Dorayaki:
//        Impilare i dorayaki man mano che vengono cotti.
//        Gustare al naturale o farcire con confetture e creme a piacere.
    ]
    
    var body: some View {
        VStack {
            // Passa gli ingredienti a IngredientsSquare
            IngredientsSquareMuffin(ingredients: ingredients)
            
            Button(action: {
                // Azione da eseguire quando viene premuto il pulsante della colazione
            }) {
//                NavigationLink(destination: BreakfastRecipesView()) {
                    ZStack{
                        Text("Prepata")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(width: 180, height: 90) // Imposta larghezza e altezza del Text
                            .foregroundColor(.white)
                            .background(Color.black)
                            .cornerRadius(30) // Maggiore valore per arrotondare gli angoli
                            .font(.largeTitle) // Imposta la dimensione del testo
                        
                        Image("colazione")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 180, height: 90)
                            .cornerRadius(30)
                            .clipped()
                            .opacity(0.4)
                    }
//                }
            }
        }
        .padding()
//        .navigationBarTitle("Muffin con gocce di cioccolato", displayMode: .inline) // Imposta il titolo della barra di navigazione
//        .navigationBarBackButtonHidden(true) // Nasconde il pulsante di back
        
    }
}


struct IngredientsSquareDorayaki: View {
    var ingredients: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("INGREDIENTI")
                .font(.headline)
                .padding(.bottom, 8)
            
            ForEach(ingredients, id: \.self) { ingredient in
                Text(ingredient)
            }
        }
        .padding()
        .background(Color.blue.opacity(0.1)) // Cambia il colore e l'opacità come preferisci
        .cornerRadius(12)
        .padding()
    }
}
