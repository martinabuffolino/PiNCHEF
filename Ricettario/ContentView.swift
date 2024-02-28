import SwiftUI

// Sezione ContentView
struct ContentView: View {
    @State private var isHeartRed = false   // Stato per gestire il colore del cuore
    @State private var savedRecipes = [Recipe]() // Array contenente le ricette salvate
    @State private var randomRecipes: [Recipe] = []
    
    var body: some View {
        NavigationView {
            TabView {
                //  View per schermata principale
                //  (stato per gestire il colore del cuore, array ricette salvate, elenco ricette per la colazione)
                HomeView(isHeartRed: $isHeartRed, savedRecipes: $savedRecipes, randomRecipes: $randomRecipes, antipastiRecipes: antipastiRecipes)
                    .tabItem {
                        Image(systemName: "fork.knife")
                    }
                //  View per salvare ricette (array ricette salvate)
                SavedRecipesView(savedRecipes: $savedRecipes)
                    .tabItem {
                        Image(systemName: "heart")
                    }
            }
        }
        .onAppear {
            // Imposta 2 ricette casuali all'avvio dell'app
            self.randomRecipes = self.getRandomRecipes(numberOfRecipes: 2)
        }
    }
    
    // Metodo per ottenere un numero specifico di ricette casuali dall'array allRecipes
    private func getRandomRecipes(numberOfRecipes: Int) -> [Recipe] {
        var allRecipesCopy = allRecipes
        allRecipesCopy.shuffle()
        let randomRecipes = Array(allRecipesCopy.prefix(numberOfRecipes))
        return randomRecipes
    }
}

// Sezione home
struct HomeView: View {
    @Binding var isHeartRed: Bool   // Stato per gestire il colore del cuore
    @Binding var savedRecipes: [Recipe] // Array contenente le ricette salvate salvate
    @Binding var randomRecipes: [Recipe] // Array contenente le ricette casuali
    
    let antipastiRecipes : [Recipe]  // Elenco ricette per la colazione
    
    var body: some View {
        NavigationView {    // Consentire la navigazione tra le view
            VStack {
                Text("Cosa vuoi mangiare oggi?")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title) // Puoi modificare lo stile del font come preferisci
                    .fontWeight(.light) // Imposta il peso del font
                    .padding(10)
                
                SearchBar() // Barra di ricerca
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack() { // Stack orizzontale per i bottoni
                        // Bottone antipasti
                        Button(action: {
                            // Azione da eseguire quando viene premuto il pulsante della colazione
                        }) {
                            NavigationLink(destination: AntipastiView(isHeartRed: $isHeartRed, savedRecipes: $savedRecipes, antipastiRecipe: antipastiRecipes)) {
                                ZStack{
                                    Text("Antipasti")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .frame(width: 150, height: 90)
                                        .foregroundColor(.white)
                                        .background(Color.black)
                                        .cornerRadius(30)
                                        .font(.largeTitle)
                                    
                                    Image("colazione")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 150, height: 90)
                                        .cornerRadius(30)
                                        .clipped()
                                        .opacity(0.4)
                                }
                            }
                        }
                        
                        // Bottone primi
                        Button(action: {
                            // Azione da eseguire quando viene premuto il pulsante della colazione
                        }) {
                            NavigationLink(destination: PrimiView(isHeartRed: $isHeartRed, savedRecipes: $savedRecipes, primiRecipe: primiRecipes)) {
                                ZStack{
                                    Text("Primi")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .frame(width: 150, height: 90)
                                        .foregroundColor(.white)
                                        .background(Color.black)
                                        .cornerRadius(30)
                                        .font(.largeTitle)
                                    
                                    Image("pranzo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 150, height: 90)
                                        .cornerRadius(30)
                                        .clipped()
                                        .opacity(0.4)
                                }
                            }
                        }
                        
                        // Bottone secondi
                        Button(action: {
                            // Azione da eseguire quando viene premuto il pulsante della colazione
                        }) {
                            NavigationLink(destination: SecondiView(isHeartRed: $isHeartRed, savedRecipes: $savedRecipes, secondiRecipe: secondiRecipes)) {
                                ZStack{
                                    Text("Secondi")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .frame(width: 150, height: 90)
                                        .foregroundColor(.white)
                                        .background(Color.black)
                                        .cornerRadius(30)
                                        .font(.largeTitle)
                                    
                                    Image("cena")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 150, height: 90)
                                        .cornerRadius(30)
                                        .clipped()
                                        .opacity(0.4)
                                }
                            }
                        }
                        
                        // Bottone dolci
                        Button(action: {
                            // Azione da eseguire quando viene premuto il pulsante della colazione
                        }) {
                            NavigationLink(destination: DolciView(isHeartRed: $isHeartRed, savedRecipes: $savedRecipes, dolciRecipe: dolciRecipes)) {
                                ZStack{
                                    Text("Dolci")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .frame(width: 150, height: 90)
                                        .foregroundColor(.white)
                                        .background(Color.black)
                                        .cornerRadius(30)
                                        .font(.largeTitle)
                                    
                                    Image("cena")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 150, height: 90)
                                        .cornerRadius(30)
                                        .clipped()
                                        .opacity(0.4)
                                }
                            }
                        }
                    }
                    .padding()
                }
                
                Text("RICETTE DEL GIORNO")
                    .font(.title)
                    .fontWeight(.light)
                    .padding(.top, 10)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        Spacer()
                        // Seleziona un numero specifico di ricette casuali dall'array allRecipes
                        ForEach(randomRecipes) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                RecipeCard(recipe: recipe, isHeartRed: self.isRecipeSaved(recipe), toggleHeart: {
                                    if self.isRecipeSaved(recipe) {
                                        self.savedRecipes.removeAll(where: { $0.title == recipe.title }) // Remove the recipe from saved recipes if it's already saved
                                    } else {
                                        self.savedRecipes.append(recipe) // Add the recipe to saved recipes
                                    }
                                })
                            }
                        }

                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .background(Color.white) // Sfondo bianco per il resto della schermata
        }
    }
    
    // Metodo per controllare se una ricetta è salvata
    func isRecipeSaved(_ recipe: Recipe) -> Bool {
        return savedRecipes.contains { $0.id == recipe.id }
        // Verifichiamo se l'ID della ricetta corrente è presente nell'elenco delle ricette salvate
    }
}

// Sezione ricerca: COLAZIONE
struct AntipastiView: View {
    @Binding var isHeartRed: Bool
    @Binding var savedRecipes: [Recipe]
    var antipastiRecipe: [Recipe]
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(antipastiRecipe) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        RecipeCard(recipe: recipe, isHeartRed: self.isRecipeSaved(recipe), toggleHeart: {
                            if self.isRecipeSaved(recipe) { // Se la ricetta è già salvata
                                self.savedRecipes.removeAll(where: { $0.id == recipe.id })
                                // Rimuoviamo ricetta dall'elenco delle ricette salvate
                            } else {
                                self.savedRecipes.append(recipe)    // Aggiungiamo ricetta all'elenco delle ricette salvate
                            }
                        })
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding()
            }
            .navigationTitle("Antipasti")
        }
    }
    
    // Metodo per controllare se una ricetta è salvata
    func isRecipeSaved(_ recipe: Recipe) -> Bool {
        return savedRecipes.contains { $0.id == recipe.id }
        // Verifichiamo se l'ID della ricetta corrente è presente nell'elenco delle ricette salvate
    }
}

// Sezione ricerca: PRANZO
struct PrimiView: View {
    @Binding var isHeartRed: Bool
    @Binding var savedRecipes: [Recipe]
    var primiRecipe: [Recipe]
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(primiRecipe) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        RecipeCard(recipe: recipe, isHeartRed: self.isRecipeSaved(recipe), toggleHeart: {
                            if self.isRecipeSaved(recipe) { // Se la ricetta è già salvata
                                self.savedRecipes.removeAll(where: { $0.id == recipe.id })
                                // Rimuoviamo ricetta dall'elenco delle ricette salvate
                            } else {
                                self.savedRecipes.append(recipe)    // Aggiungiamo ricetta all'elenco delle ricette salvate
                            }
                        })
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding()
            }
            .navigationTitle("Primi")
        }
    }
    
    // Metodo per controllare se una ricetta è salvata
    func isRecipeSaved(_ recipe: Recipe) -> Bool {
        return savedRecipes.contains { $0.id == recipe.id }
        // Verifichiamo se l'ID della ricetta corrente è presente nell'elenco delle ricette salvate
    }
}

// Sezione ricerca: CENA
struct SecondiView: View {
    @Binding var isHeartRed: Bool
    @Binding var savedRecipes: [Recipe]
    var secondiRecipe: [Recipe]
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(secondiRecipe) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        RecipeCard(recipe: recipe, isHeartRed: self.isRecipeSaved(recipe), toggleHeart: {
                            if self.isRecipeSaved(recipe) { // Se la ricetta è già salvata
                                self.savedRecipes.removeAll(where: { $0.id == recipe.id })
                                // Rimuoviamo ricetta dall'elenco delle ricette salvate
                            } else {
                                self.savedRecipes.append(recipe)    // Aggiungiamo ricetta all'elenco delle ricette salvate
                            }
                        })
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding()
            }
            .navigationTitle("Secondi")
        }
    }
    
    // Metodo per controllare se una ricetta è salvata
    func isRecipeSaved(_ recipe: Recipe) -> Bool {
        return savedRecipes.contains { $0.id == recipe.id }
        // Verifichiamo se l'ID della ricetta corrente è presente nell'elenco delle ricette salvate
    }
}

// Sezione ricerca: DOLCI
struct DolciView: View {
    @Binding var isHeartRed: Bool
    @Binding var savedRecipes: [Recipe]
    var dolciRecipe: [Recipe]
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(dolciRecipe) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        RecipeCard(recipe: recipe, isHeartRed: self.isRecipeSaved(recipe), toggleHeart: {
                            if self.isRecipeSaved(recipe) { // Se la ricetta è già salvata
                                self.savedRecipes.removeAll(where: { $0.id == recipe.id })
                                // Rimuoviamo ricetta dall'elenco delle ricette salvate
                            } else {
                                self.savedRecipes.append(recipe)    // Aggiungiamo ricetta all'elenco delle ricette salvate
                            }
                        })
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding()
            }
            .navigationTitle("Dolci")
        }
    }
    
    // Metodo per controllare se una ricetta è salvata
    func isRecipeSaved(_ recipe: Recipe) -> Bool {
        return savedRecipes.contains { $0.id == recipe.id }
        // Verifichiamo se l'ID della ricetta corrente è presente nell'elenco delle ricette salvate
    }
}

// Sezione ricette salvate
struct SavedRecipesView: View {
    @Binding var savedRecipes: [Recipe]
    
    var body: some View {
        ScrollView {
            VStack {
                // Utilizziamo RecipeCard per visualizzare la ricetta
                ForEach(savedRecipes) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe))  {
                        RecipeCard(recipe: recipe, isHeartRed: self.isRecipeSaved(recipe), toggleHeart: {
                            if self.isRecipeSaved(recipe) { // Se la ricetta è già salvata
                                self.savedRecipes.removeAll(where: { $0.id == recipe.id })
                                // Rimuoviamo ricetta dall'elenco delle ricette salvate
                            } else {
                                self.savedRecipes.append(recipe)    // Aggiungiamo ricetta all'elenco delle ricette salvate
                            }
                        })
                    }
                }
                .padding()
            }
            .navigationTitle("Ricette Salvate")
        }
    }
    
    // Metodo per controllare se una ricetta è salvata
    func isRecipeSaved(_ recipe: Recipe) -> Bool {
        return savedRecipes.contains { $0.id == recipe.id }
        // Verifichiamo se l'ID della ricetta corrente è presente nell'elenco delle ricette salvate
    }
}

// Barra di ricerca
struct SearchBar: View {
    @State private var searchText = ""
    
    var body: some View {
        ZStack(alignment: .leading) {
            TextField("Cerca ricetta", text: $searchText)
                .padding(7)
                .padding(.leading, 30) // Aggiunge spazio a sx per il testo evitando la sovrapposizione con l'icona
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 15)
            
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.leading, 15) // Allinea l'icona con il bordo sinistro della TextField
        }
    }
}

// Struttura generica per la visualizzazione di una ricetta
struct RecipeView: View {
    var recipe: Recipe
    @Binding var isHeartRed: Bool
    
    var body: some View {
        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
            RecipeCard(recipe: recipe, isHeartRed: isHeartRed, toggleHeart: {})
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// Struttura blocco ricetta con image, heart, title e description
struct RecipeCard: View {
    var recipe: Recipe
    var isHeartRed: Bool
    var toggleHeart: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                Image(recipe.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 150)
                    .cornerRadius(8)
                    .clipped()
                
                Button(action: {
                    toggleHeart()
                }) {
                    Image(systemName: isHeartRed ? "heart.fill" : "heart")
                        .foregroundColor(isHeartRed ? .red : .white)
                        .padding(8)
                        .background(Color.black.opacity(0.6))
                        .clipShape(Circle())
                        .padding(8)
                }
            }
            
            Text(recipe.title)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(recipe.description)
                .foregroundColor(.secondary)
                .font(.subheadline)
                .lineLimit(2)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
        .padding(.horizontal)
    }
}

struct RecipePropertyView: View {
    var imageName: String
    var value: String
    var label: String

    var body: some View {
        VStack {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 35)
                    .foregroundColor(.white)
                Text(value)
                    .fontWeight(.black)
                    .font(.system(size: 25))
                    .foregroundColor(.white)
                Spacer()
            }
            Text(label)
                .fontWeight(.black)
                .padding(.bottom, 5)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(10)
        .background(Color.yellow)
        .cornerRadius(10)

    }
}



// Struttura dettagli ricetta con ingredinenti
struct RecipeDetailView: View {
    @StateObject private var watchConnector:WatchConnector = WatchConnector()
    
    var recipe: Recipe
    
    // Dichiarazione della variabile expandedSteps al livello della vista
//    @State private var expandedSteps: Set<Int> = []
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack{
                VStack(alignment: .leading){
                    ZStack{
                        Image(recipe.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, maxHeight: 200)
                            .edgesIgnoringSafeArea(.horizontal)
                            .aspectRatio(4/3, contentMode: .fill)
                            .frame(height: 200)
                            .clipped()
                        
                        Color.black.opacity(0.5)
                            .frame(maxWidth: .infinity, maxHeight: 200)
                            .edgesIgnoringSafeArea(.horizontal)
                            .aspectRatio(4/3, contentMode: .fill)
                            .frame(height: 200)
                        
                        Text(recipe.title)
                            .fontWeight(.black)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 15)
                            .padding(.vertical)
                            .foregroundColor(.white)
                            .font(.system(size: 40))
                            .lineLimit(nil)
                    }
                    
                    VStack{
                        HStack {
                            VStack(spacing: 10) {
                                HStack(spacing: 10) {
                                    RecipePropertyView(imageName: "frying.pan.fill", value: "\(recipe.difficulty)", label: "Difficulty")
                                    RecipePropertyView(imageName: "person.fill", value: "\(recipe.servingSize)", label: "Serving")
                                }
                                HStack(spacing: 10) {
                                    RecipePropertyView(imageName: "timer", value: "\(recipe.time)m", label: "Time")
                                    RecipePropertyView(imageName: "dollarsign.circle.fill", value: "\(recipe.cost)", label: "Cost")
                                }
                            }
                        }
                    }.padding()

                    Text("Ingredients")
                        .font(.system(size: 35))
                        .fontWeight(.bold)
                        .foregroundColor(Color.yellow)
                        .padding(.vertical, 5)
                        .padding(.horizontal,15)
                    Divider()
                    
                    HStack{
                        Spacer()
                        
                        ZStack{
                            VStack(alignment: .leading, spacing: 5) {
                                ForEach(recipe.ingredients, id: \.name) { ingredient in
                                    HStack {
                                        Circle()
                                            .frame(width: 15, height: 15)
                                            .foregroundColor(Color.white)
                                            .shadow(radius: 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(Color.black, lineWidth: 0.3)
                                            )
                                        Text("\(ingredient.name)")
                                            .fontWeight(.semibold)
                                            .font(.system(size: 22))
                                        Spacer()
                                        Text("\(ingredient.quantity)")
                                            .fontWeight(.black)
                                            .font(.system(size: 18))
                                    }
                                    Divider()
                                }
                            }
                            .font(.headline)
                            .fontWeight(.medium)
                            .padding(15)
                            .frame(maxWidth: .infinity)
                            .background(Color.clear)
                            .overlay(
                                Rectangle()
                                    .stroke(Color.black, lineWidth: 0.3)
                            )
                        }.background(Color(red: 249/255, green: 246/255, blue: 227/255))
                        Spacer()
                    }
                    
                    Spacer()
                    Spacer()
                    Spacer()
                    HStack(spacing: 20){
                        Spacer()
                        Button(action: {
                            
                        }) {
                            NavigationLink(destination: instructionsView(recipe: recipe)) {
                                Text("Instructions")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 17))
                                    .fontWeight(.black)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(30)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(Color.yellow, lineWidth: 4)
                                    )
                                    .shadow(radius: 3)
                            }
                        }
                        Button(action: {
                            watchConnector.sendMessage(key: "testo", value: "Cambiami")
                        }) {
                            Text("Watch and Cook!")
                                .foregroundColor(.white)
                                .font(.system(size: 17))
                                .fontWeight(.black)
                                .padding()
                                .background(Color.yellow)
                                .cornerRadius(30)
                                .shadow(radius: 3)
                        }
                        Spacer()
                    }
                    Spacer()
                                           
//                    VECCHIO
//                    Text("Instructions")
//                        .font(.system(size: 35))
//                        .fontWeight(.bold)
//                        .foregroundColor(Color.yellow)
//                        .padding(.vertical, 5)
//                        .padding(.horizontal,15)

//                    ForEach(recipe.instructions.indices, id: \.self) { index in
//                        let stepNumber = index + 1
//                        let instruction = recipe.instructions[index]
//                        VStack(alignment: .leading, spacing: 5) {
//                            Text("Step \(stepNumber)")
//                                .fontWeight(.bold)
//                                .foregroundColor(.yellow)
//                                .padding(.horizontal, 15)
//                            Text(instruction.text)
//                                .font(.title3)
//                                .fontWeight(.medium)
//                                .padding(.horizontal, 15)
//                                .padding(.bottom, 5)
//                        }
//                    }
                }
            }
            Spacer().frame(height: 25)
        }
    }
}

struct instructionsView: View {
    
    var recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(recipe.instructions.indices, id: \.self) { index in
                    let stepNumber = index + 1
                    let instruction = recipe.instructions[index]
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Step \(stepNumber)")
                            .fontWeight(.bold)
                            .foregroundColor(.yellow)
                            .padding(.horizontal, 15)
                        Text(instruction.text)
                            .font(.title3)
                            .fontWeight(.medium)
                            .padding(.horizontal, 15)
                            .padding(.bottom, 5)
                    }
                }
                .padding()
            }
            .navigationTitle("Dolci")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
