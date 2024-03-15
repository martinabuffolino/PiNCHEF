import SwiftUI


struct ContentView: View {
    @StateObject private var watchConnector: WatchConnector = WatchConnector()
    
    @State var currentRecipe: Recipe = Recipe(title: "", ingredients: [], instructions: [], imageName: "", description: "", isHeartRed: false, difficulty: .easy, time: 0, cost: .low, servingSize: 0)
    
    @State var currentInstruction = -1
    
    @State var scrollAmount = 0.0
    
    @State var endRecipe = false
    
    @State var savedRec: [Recipe] = []
    
    @State var timer: Timer? // Aggiunto per gestire il timer
    @State private var timerDuration: Int = 0
    @State private var timerRemaining: Int = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if currentRecipe.title == ""{
        
                if !savedRec.isEmpty{
                    
                    VStack(alignment: .leading){
                        Text("Favorites")
                            .font(.title2)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 20)
                        
                        ScrollView(.vertical) {
                            // Utilizziamo RecipeCard per visualizzare la ricetta
                            ForEach(savedRec) { recipe in
                                Button(action: {currentRecipe = recipe}) {
                                    HStack{
                                        Image(systemName: "heart.fill")
                                            .foregroundColor(.red)
                                        
                                        Text(recipe.title)
                                            .lineLimit(1)
                                        Spacer()
                                    }
                                }
                                
                            }
                        }
                    }
                    .padding(.top, 0)
                    .ignoresSafeArea()
                    
                }
                else{
                    NoRecipeView()
                }
            }
            else{
                
                if currentInstruction < 0{
                    StartW()
                }
                else if endRecipe == false{
                    VStack{
                        
                        // Timer circolare posizionato in alto a sinistra
                        if timerRemaining > 0 {
                            VStack {
                                Circle()
                                    .stroke(lineWidth: 5)
                                    .opacity(0.3)
                                    .foregroundColor(Color.gray)

                                Circle()
                                    .trim(from: 0, to: CGFloat(timerRemaining) / CGFloat(timerDuration))
                                    .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                                    .foregroundColor(Color.green)
                                    .rotationEffect(Angle(degrees: 270))
                                    .animation(.linear, value: timerRemaining)

                                Text("\(timerRemaining)s")
                                    .font(.caption)
                            }
                            .frame(width: 50, height: 50)
                            .padding([.top, .leading], 8)
                            
                            Divider()
                        }
            
                        
                        VStack(alignment: .leading) {
                            // Controlla se la ricetta è terminata
                            if currentInstruction < currentRecipe.instructions.count{
                                Text(currentRecipe.instructions[currentInstruction].type)
                                    .font(.system(size: 50))
                                
                                // TODO: cambia
                                Text("10 min")
                                    .bold()
                                    .font(.system(size: 20))
                                
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
                    EndRecipeView()
                }
                
                // Logica legata alla rotazione della Crown
                Text("")
                    .focusable(true)
                    .digitalCrownRotation($scrollAmount, from: -1.0, through: 1.0, by: 0.1, sensitivity: .low, isContinuous: false)
                    .onChange(of: scrollAmount) {
                        if Int(scrollAmount) == 1{
                            print("avanti")
                            currentInstruction += 1
                
                            scrollAmount = 0
                            
                            // Se vado avanti dopo il termine della ricetta torna alla home
                            if endRecipe{
                                endRecipe = false
                                
                                currentRecipe = Recipe(title: "", ingredients: [], instructions: [], imageName: "", description: "", isHeartRed: false, difficulty: .easy, time: 0, cost: .low, servingSize: 0)
                                
                                currentInstruction = -1
                            }
                            
                            checkAndStartTimerForCurrentStep()
                        }
                        else if Int(scrollAmount) == -1{
                            print("indietro")
                            currentInstruction -= 1
                            if currentInstruction == -2{
                                currentInstruction = -1
                                
                                // Torna alla schermata inziale
                                currentRecipe = Recipe(title: "", ingredients: [], instructions: [], imageName: "", description: "", isHeartRed: false, difficulty: .easy, time: 0, cost: .low, servingSize: 0)
                            }
                            scrollAmount = 0
                            
                            endRecipe = false
                            
                            checkAndStartTimerForCurrentStep()
                            
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
        .onChange(of: watchConnector.addPrefTitle) {
            if let recipe = allRecipes.first(where: { $0.title == watchConnector.addPrefTitle}) {
                savedRec.append(recipe)
            }
        }
        .onChange(of: watchConnector.rmvPrefTitle) {
            savedRec.removeAll { $0.title ==  watchConnector.rmvPrefTitle}
        }
        
        
    }
    
    
    func checkAndStartTimerForCurrentStep() {
        //        timer?.invalidate() // Ferma il timer precedente se attivo
        if currentInstruction >= 0 && currentInstruction < currentRecipe.instructions.count {
            let step = currentRecipe.instructions[currentInstruction]
            if let stepTimer = step.timer {
                timerDuration = stepTimer
                timerRemaining = stepTimer
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    if timerRemaining > 0 {
                        timerRemaining -= 1
                    } else {
                        timer?.invalidate()
                    }
                }
            }
        }
    }
    
    
}
    



#Preview {
    ContentView()
}
