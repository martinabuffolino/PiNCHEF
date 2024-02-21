//
//  PancakeView.swift
//  Ricettario
//
//  Created by Martina Buffolino on 19/02/24.
//

import Foundation
import SwiftUI

struct PancakeView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var stepIndex = 0
    
    // Aggiungi un parametro per gli ingredienti
    let ingredients: [String] = [
        "Farina 00 125 g",
        "Latte intero 200 g",
        "Burro 25 g",
        "Zucchero 15 g",
        "Uova medie 2",
        "Lievito in polvere per dolci 6 g",
        "Sale fino 1 pizzico",
        "PER UNGERE LA PADELLA",
        "Burro q.b.",
        "PER GUARNIRE",
        "Sciroppo di acero q.b.",
        "More q.b.",
        "Lamponi q.b."
    ]
    
    var preparationSteps: [String] = [
//       Sciogliere il burro in un pentolino e lasciarlo intiepidire.
//        Separare i tuorli dagli albumi.
//        Versare il burro fuso intiepidito nella ciotola con i tuorli, aggiungere il latte e mescolare con una frusta.
//        Aggiungere la farina setacciata alla miscela di tuorli e mescolare.
//        Setacciare anche il lievito e incorporarlo nella miscela, quindi aggiungere il sale e mescolare fino a ottenere un composto omogeneo.
//        Montare gli albumi a neve nella ciotola separata utilizzando le fruste elettriche, aggiungendo gradualmente lo zucchero.
//        Incorporare gli albumi montati a neve nel composto di tuorli, mescolando delicatamente dal basso verso l'alto.
//        Scaldare una padella antiaderente con un po' di burro e versare al centro un mestolo di impasto.
//        Cuocere a fuoco moderato per un paio di minuti, girare delicatamente il pancake quando compaiono le prime bollicine e cuocere brevemente anche dall'altro lato fino a doratura.
//        Trasferire i pancake cotti su un piatto senza impilarli.
//        Una volta cotti tutti i pancake, impilarli e servirli con abbondante sciroppo d'acero.
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
        .navigationBarTitle("Pancake allo sciroppo d'acero", displayMode: .inline) // Imposta il titolo della barra di navigazione
//        .navigationBarBackButtonHidden(true) // Nasconde il pulsante di back
        
    }
}


struct IngredientsSquarePancake: View {
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
