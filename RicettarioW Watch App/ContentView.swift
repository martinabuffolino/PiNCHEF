import SwiftUI


struct ContentView: View {
    @StateObject private var watchConnector: WatchConnector = WatchConnector()
    
    @State var currentRecipe: Recipe = Recipe(title: "", ingredients: [], instructions: [], imageName: "", description: "", isHeartRed: false, difficulty: .easy, time: 0, cost: .low, servingSize: 0)
    
    @State var currentInstruction = -1
    
    @State var scrollAmount = 0.0
    
    @State var endRecipe = false
    
    @State var savedRec: [Recipe] = allRecipes
//    @State var savedRec: [Recipe] = []

    
    @State var timer: Timer? // Aggiunto per gestire il timer
    @State var isTimerRunning = false
    @State private var timerDuration: Int = 0
    @State private var timerRemaining: Int = 0
    
    @State private var endTimerView = false
    
    @State var stepWithTimer: Step = Step(type: "", text: "")
    
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
                            .padding(.leading, 4)
                        
                        ScrollView(.vertical) {
                            // Utilizziamo RecipeCard per visualizzare la ricetta
                            ForEach(savedRec) { recipe in
                                Button(action: {currentRecipe = recipe}) {
                                    HStack {
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
                        VStack(alignment: .leading) {
                            ZStack {
                                    Circle()
                                        .stroke(lineWidth: 4)
                                        .opacity(0.3)
                                        .foregroundColor(Color.gray)

                                    Circle()
                                        .trim(from: 0, to: CGFloat(timerRemaining) / CGFloat(timerDuration))
                                        .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                                        .foregroundColor(Color.green)
                                        .rotationEffect(Angle(degrees: 270))
                                        .animation(.linear, value: timerRemaining)

//                                    Text("\(timerRemaining)s")
//                                        .font(.caption)
                                    Text("\(stepWithTimer.type)")
                                        .font(.caption)
                                }
                                .frame(width: 30, height: 30)
                                .padding( .leading, 8)
                                .padding(.bottom, 2)
                            
                            Divider()
                        }
                        .opacity(timerRemaining > 0 ? 1 : 0)
            
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            // Controlla se la ricetta è terminata
                            if currentInstruction < currentRecipe.instructions.count{
                                VStack {
                                    Text(currentRecipe.instructions[currentInstruction].type)
                                        .font(.system(size: 34))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    // TODO: rivedere grafica
                                    Text("\((currentRecipe.instructions[currentInstruction].timer ?? 0) / 60) min")
                                        .bold()
                                        .font(.system(size: 16))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .opacity(0.6)
                                    
                                    
                                    Text("\(currentRecipe.instructions[currentInstruction].text)\n\n\n")
                                        .font(.system(size: 14))
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(3)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    
                                }
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                            }
                            else{
                                VStack {
                                    Spacer()
                                    
                                    Button(action: {endTimerView = true}) {
                                        Text("Timer")
                                            .bold()
                                    }
                                    
                                    Spacer()
                                    
                                    Button(action: {timerRemaining = 1}) {
                                        Text("Finish Recipe")
                                            .bold()
                                    }
                                    
                                    Spacer()
                                    
                                }
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                                .onAppear(){
                                    // Se termina la ricetta ma c'è il timer in corso mostra solo quello
                                    if isTimerRunning{
                                        endTimerView = true
                                    }
                                    else{
                                        endRecipe = true
                                    }
                                }
                                .onChange(of: endTimerView){
                                    if !isTimerRunning{
                                        endRecipe = true
                                    }
                                }
                            }
                            
                        }
                        .padding(.horizontal)
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
                            
                            
                        }
                        
                    }
                
            }
            
        }
        // Schermata di fine timer
        .sheet(isPresented: $endTimerView, content: {
            VStack {
                
                HStack {
                    Spacer()
                    
                    Text(stepWithTimer.type)
                        .font(.system(size: 65))
                    
                    Spacer()
                    
                    ZStack {
                            Circle()
                                .stroke(lineWidth: 8)
                                .opacity(0.3)
                                .foregroundColor(Color.gray)

                            Circle()
                                .trim(from: 0, to: CGFloat(timerRemaining) / CGFloat(timerDuration))
                                .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
                                .foregroundColor(Color.green)
                                .rotationEffect(Angle(degrees: 270))
                                .animation(.linear, value: timerRemaining)

                            if timerRemaining > 60{
                                Text("\(timerRemaining / 60)m")
                                .bold()
                                .font(.system(size: 24))
                            }
                            else{
                                Text("\(timerRemaining)s")
                                .bold()
                                .font(.system(size: 24))
                            }
                            
                        }
                    .frame(width: 60, height: 60)
                    
                    Spacer()
                }
                .padding(.bottom, 4)
                
                Text("\(stepWithTimer.text)\n\n\n")
                    .lineLimit(4)
                    .opacity(0.6)
                    .onAppear(){
                        WKInterfaceDevice.current().play(.notification)
                    }
            }
        })
        
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
        guard !isTimerRunning else {
            return // Se il timer è già in esecuzione, esce dalla funzione
        }

        if currentInstruction >= 1 && currentInstruction < currentRecipe.instructions.count {
            
            // Se lo step precedente aveva il timer lo avvia
            let step = currentRecipe.instructions[currentInstruction-1]
            if let stepTimer = step.timer {
                stepWithTimer = step
                timerDuration = stepTimer
                timerRemaining = stepTimer
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    if timerRemaining > 0 {
                        timerRemaining -= 1
                        isTimerRunning = true
                        // Imposta la variabile di blocco su true quando il timer viene avviato
                        
                        // Quando mancano 10 secondi si visualizza la schermata
                        if timerRemaining <= 10{
                            endTimerView = true
                        }
                        
                    } else {
                        timer?.invalidate()
                        isTimerRunning = false 
                        // Imposta la variabile di blocco su false quando il timer termina
                        print("timer end")
                        
                        endTimerView = false
                    }
                }
            }
        }
    }

    
    
}
    



#Preview {
    ContentView()
}
