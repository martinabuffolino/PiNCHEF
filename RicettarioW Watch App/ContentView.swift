import SwiftUI

struct ContentView: View {
    
    @StateObject private var watchConnector: WatchConnector = WatchConnector()
    
    @State var currentRecipe: Recipe = Recipe(title: "", ingredients: [], instructions: [], imageName: "", description: "", isHeartRed: false, difficulty: .easy, time: 0, cost: .low, servingSize: 0)
    
    @State var currentInstruction = -1
    
    @State var scrollAmount = 0.0
    
    @State var endRecipe = false
    
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
                else if endRecipe == false{
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
                                    .onAppear(){endRecipe = true}
                            }
                            
                        }
                        .padding()
                    }
                    
                }
                else{
                    EndRecipeView(imageRecipe: Image(currentRecipe.imageName))
                }
                
                
                Text("")
                    .focusable(true)
                    .digitalCrownRotation($scrollAmount, from: -1.0, through: 1.0, by: 0.1, sensitivity: .low, isContinuous: false)
                    .onChange(of: scrollAmount) {
                        if Int(scrollAmount) == 1{
                            print("avanti")
                            currentInstruction += 1
                            scrollAmount = 0
                            
                            // Se vado avanti dopo aver terminato la ricetta torna alla schermata home
                            if endRecipe{
                                endRecipe = false
                                
                                currentRecipe = Recipe(title: "", ingredients: [], instructions: [], imageName: "", description: "", isHeartRed: false, difficulty: .easy, time: 0, cost: .low, servingSize: 0)
                                
                                currentInstruction = -1
                            }
                        }
                        else if Int(scrollAmount) == -1{
                            print("indietro")
                            currentInstruction -= 1
                            if currentInstruction == -2{
                                currentInstruction = -1
                            }
                            scrollAmount = 0
                            
                            endRecipe = false
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

