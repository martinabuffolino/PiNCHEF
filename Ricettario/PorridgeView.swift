//
//  PorridgeView.swift
//  Ricettario
//
//  Created by Martina Buffolino on 19/02/24.
//

import Foundation
import SwiftUI

struct PorridgeView: View {
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
//        Preparazione del burro: Lasciate il burro fuori dal frigo per almeno 1 ora in modo da ammorbidirlo.
//        Lavorazione del burro e dello zucchero: Unite il burro morbido allo zucchero e lavorate con le fruste elettriche fino ad ottenere un composto spumoso e cremoso.
//        Preparazione della vaniglia: Incidete una bacca di vaniglia e raschiate i semi utilizzando il dorso di un coltello.
//        Aggiunta delle uova: Versate le uova a temperatura ambiente, una alla volta, nel composto di burro e zucchero e azionate nuovamente le fruste.
//        Setacciatura degli ingredienti secchi: Setacciate la farina, il lievito per dolci e il bicarbonato direttamente nel composto.
//        Aggiunta del sale: Aggiungete un pizzico di sale e azionate nuovamente le fruste per inglobare le polveri.
//        Aggiunta del latte: Stemperate il composto con il latte a temperatura ambiente versato a filo.
//        Aggiunta delle gocce di cioccolato: Unite 80 g di gocce di cioccolato e mescolate con una spatola per inglobarle nel composto.
//        Trasferimento del composto nei pirottini: Trasferite il composto in una sac-a-poche usa e getta senza bocchetta o utilizzate un cucchiaio per riempire i pirottini per 2/3.
//        Decorazione con le gocce di cioccolato: Versate le gocce di cioccolato rimanenti sulle tortine.
//        Cottura: Cuocete in forno preriscaldato a 180°C per 18-20 minuti in modalità statica.
//        Servire: Una volta cotti, i muffin con gocce di cioccolato sono pronti per essere gustati.
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


struct IngredientsSquarePorridge: View {
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
