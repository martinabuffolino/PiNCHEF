//
//  StartWatch.swift
//  RicettarioW Watch App
//
//  Created by Carmine De Micco on 28/02/24.
//
import WatchKit
import SwiftUI

    struct StartW: View {
        @State private var emoji = "🤏"
        @State private var isNextEmoji = false
        
        let emojis = ["👌💥","🤏"] // Array di emoji da mostrare
        
        var body: some View {
            VStack {
                Spacer()
                Text("Watch and Cook!")
                    .font(.title3)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.top,0)
                Spacer()
                VStack {
                    Spacer()
                    Text("Tap your fingers to go to the next step.")
                                        .opacity(0.7)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.headline)
                    Spacer()
                    Text(emoji)
                        .font(.title)
                    Spacer()
                    Text("Tap two times to go to the previous step")
                        .font(.headline)
                        .opacity(0.7)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.bottom,0)
                }
            }
            
            .background(Color.black)
            .padding()
            .onAppear {
                // Avvia il timer quando la vista appare
                Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
                    withAnimation {
                        if self.isNextEmoji {
                            let currentIndex = (self.emojis.firstIndex(of: self.emoji) ?? 0)
                            let nextIndex = (currentIndex + 1) % self.emojis.count
                            self.emoji = self.emojis[nextIndex]
                        } else {
                            let currentIndex = (self.emojis.firstIndex(of: self.emoji) ?? 0)
                            let nextIndex = (currentIndex - 1 + self.emojis.count) % self.emojis.count
                            self.emoji = self.emojis[nextIndex]
                        }
                    }
                }
            }
        }
    }

#Preview {
    StartW()
}
