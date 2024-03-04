import SwiftUI

struct ContentView: View {
    
    @StateObject private var watchConnector: WatchConnector = WatchConnector()
    
    @State var currentRecipe: Recipe = Recipe(title: "", ingredients: [], instructions: [], imageName: "", description: "", isHeartRed: false, difficulty: 0, time: 0, cost: 0, servingSize: 0)
    
    @State var currentInstruction = -1
    
    @State var scrollAmount = 0.0
    
    var body: some View {
        VStack(alignment: .leading) {
            if currentRecipe.title == ""{
                // Sostituisci con una View iniziale
                // magari che avvisi di attivare l'assistive touch
                // o che permetta di selezionare tra le ricette nei preferiti
                Text("Avvia da iPhone")
                    
            }
            else{
                
                if currentInstruction < 0{
                    StartW()
                }
                else{
                    VStack{
                        Text("Timer, \(currentRecipe.title)")
                            .padding(.top, 0)
                        
                        Divider()
                        
                        VStack(alignment: .leading) {
                            Text("🔥")
                                .font(.system(size: 50))
                                
                            Text("10 min")
                                .bold()
                                .font(.system(size: 20))
                                
                            if currentInstruction < currentRecipe.instructions.count{
                                Text(currentRecipe.instructions[currentInstruction].text)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .opacity(0.5)
                                    .lineLimit(4) // Numero massimo di linee che vuoi mostrare
                                    .truncationMode(.tail)
                            }
                            else{
                                Text("Fine Ricetta")
                            }
                            
                        }
                        .padding()
                    }
                    
                }
                
                Text("")
                    .focusable(true)
                    .digitalCrownRotation($scrollAmount, from: -1.0, through: 1.0, by: 0.1, sensitivity: .low, isContinuous: false)
                    .onChange(of: scrollAmount) {
                        if Int(scrollAmount) == 1{
                            print("avanti")
                            currentInstruction += 1
                            scrollAmount = 0
                        }
                        else if Int(scrollAmount) == -1{
                            print("indietro")
                            currentInstruction -= 1
                            scrollAmount = 0
                        }

                    }
                
                
            }
            
        }
        .onChange(of: watchConnector.recipeTitle) {
            if let recipe = allRecipes.first(where: { $0.title == watchConnector.recipeTitle}) {
                currentRecipe = recipe
                currentInstruction = -1
            }
        }


    }
}

#Preview {
    ContentView()
}
