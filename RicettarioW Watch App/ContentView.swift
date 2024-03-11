import SwiftUI

struct ContentView: View {
    @StateObject private var watchConnector: WatchConnector = WatchConnector()
    
    @State var currentRecipe: Recipe = Recipe(title: "", ingredients: [], instructions: [], imageName: "", description: "", isHeartRed: false, difficulty: .easy, time: 0, cost: .low, servingSize: 0)
    
    @State var currentInstruction = -1
    
    @State var scrollAmount = 0.0
    
    @State var savedRec: [Recipe] = []
    
    @State var timer: Timer? // Aggiunto per gestire il timer
    @State private var timerDuration: Int = 0
    @State private var timerRemaining: Int = 0
    
    var body: some View {
        VStack(alignment: .leading) { 
            ZStack(alignment: .topLeading) { // Usa ZStack per sovrapporre elementi
            // Timer circolare posizionato in alto a sinistra
            if timerRemaining > 0 {
                ZStack {
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
            }
            
            if currentRecipe.title == ""{
                if !savedRec.isEmpty{
                    Text("Favorites")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 20)
//                        .ignoresSafeArea()
                    ScrollView(.vertical) {
                        // Utilizziamo RecipeCard per visualizzare la ricetta
                        ForEach(savedRec) { recipe in
                            Button(action: {
                                currentRecipe = recipe
                                
                            }) {
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
                else{
                    VStack{
                        Spacer(minLength: 60)
                        
                        Image(systemName: "heart.slash.fill")
                        Text("You have no recipes saved")
                            .multilineTextAlignment(.center)
                            .font(.headline)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 1)
                                    .frame(width: 130, height: 60)
                            )
                        VStack{
                            Spacer()
                            Text("Save or start cooking recipes from your iPhone!")
                                .multilineTextAlignment(.center)
                                .font(.footnote)
                            Spacer()
                        }
                    }
                    
                    
                }
                
                
            }else{
                
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
                            checkAndStartTimerForCurrentStep()
                            scrollAmount = 0
                        }
                        else if Int(scrollAmount) == -1{
                            print("indietro")
                            currentInstruction -= 1
                            checkAndStartTimerForCurrentStep()
                            scrollAmount = 0
                        }
                        
                    }
                
                
            }
            
        }
        }.ignoresSafeArea()
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
