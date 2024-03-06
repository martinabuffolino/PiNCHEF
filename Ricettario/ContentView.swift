import SwiftUI

// Tab bar and random function
struct ContentView: View {
    @State private var isHeartRed = false
    @State private var savedRecipes = [Recipe]()
    @State private var randomRecipes: [Recipe] = []
    
    var body: some View {
        NavigationView {
            TabView {
                HomeView(isHeartRed: $isHeartRed, savedRecipes: $savedRecipes, randomRecipes: $randomRecipes, allRecipes: allRecipes)
                    .tabItem {
                        Label("Cook", systemImage: "fork.knife")
                    }
                SavedRecipesView(savedRecipes: $savedRecipes)
                    .tabItem {
                        Label("Saved", systemImage: "heart")
                    }
            }
            .accentColor(.yellow)
        }
        .onAppear {
            self.randomRecipes = self.getRandomRecipes(numberOfRecipes: 2)
        }
    }
    
    private func getRandomRecipes(numberOfRecipes: Int) -> [Recipe] {
        var allRecipesCopy = allRecipes
        allRecipesCopy.shuffle()
        let randomRecipes = Array(allRecipesCopy.prefix(numberOfRecipes))
        return randomRecipes
    }
}

// Homepage
struct HomeView: View {
    @Binding var isHeartRed: Bool
    @Binding var savedRecipes: [Recipe]
    @Binding var randomRecipes: [Recipe]
    
    let allRecipes: [Recipe]
           
    @State private var searchText: String = ""
    
    var filteredRecipes: [Recipe] {
        if searchText.isEmpty {
            return randomRecipes
        } else {
            return allRecipes.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    Text("Recipe Book")
                        .font(.system(size: 40))
                        .fontWeight(.black)
                        .padding()
                    Spacer()
                }
                SearchBar(searchText: $searchText)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Button(action: {}) {
                            NavigationLink(destination: RecipeCategoryView(isHeartRed: $isHeartRed, savedRecipes: $savedRecipes, recipes: antipastiRecipes, category: .antipasti)) {
                                CategoryButton(title: "Appetizers", imageName: "appetizers")
                            }
                        }
                        
                        Button(action: {}) {
                            NavigationLink(destination: RecipeCategoryView(isHeartRed: $isHeartRed, savedRecipes: $savedRecipes, recipes: primiRecipes, category: .primi)) {
                                CategoryButton(title: "First Courses", imageName: "first_course")
                            }
                        }
                        
                        Button(action: {}) {
                            NavigationLink(destination: RecipeCategoryView(isHeartRed: $isHeartRed, savedRecipes: $savedRecipes, recipes: secondiRecipes, category: .secondi)) {
                                CategoryButton(title: "Second Courses", imageName: "second_course")
                            }
                        }
                        
                        Button(action: {}) {
                            NavigationLink(destination: RecipeCategoryView(isHeartRed: $isHeartRed, savedRecipes: $savedRecipes, recipes: dolciRecipes, category: .dolci)) {
                                CategoryButton(title: "Desserts", imageName: "desserts")
                            }
                        }
                    }
                    .padding()
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        if searchText.isEmpty {
                            Text("RECIPES OF THE DAY")
                                .font(.title)
                                .fontWeight(.semibold)
                                .padding(.top, 10)
                            ForEach(randomRecipes) { recipe in
                                NavigationLink(destination: RecipeDetailView(recipe: recipe, isHeartRed: self.isRecipeSaved(recipe), toggleHeart: {
                                    if self.isRecipeSaved(recipe) {
                                        self.savedRecipes.removeAll(where: { $0.id == recipe.id })
                                    } else {
                                        self.savedRecipes.append(recipe)
                                    }
                                })) {
                                    RecipeCard(recipe: recipe, isHeartRed: self.isRecipeSaved(recipe), toggleHeart: {
                                        if self.isRecipeSaved(recipe) {
                                            self.savedRecipes.removeAll(where: { $0.id == recipe.id })
                                        } else {
                                            self.savedRecipes.append(recipe)
                                        }
                                    })
                                }
                            }
                        } else {
                            Text("RESULTS")
                                .font(.title)
                                .fontWeight(.semibold)
                                .padding(.top, 10)
                            ForEach(filteredRecipes) { recipe in
                                NavigationLink(destination: RecipeDetailView(recipe: recipe, isHeartRed: self.isRecipeSaved(recipe), toggleHeart: {
                                    if self.isRecipeSaved(recipe) {
                                        self.savedRecipes.removeAll(where: { $0.id == recipe.id })
                                    } else {
                                        self.savedRecipes.append(recipe)
                                    }
                                })) {
                                    RecipeCard(recipe: recipe, isHeartRed: self.isRecipeSaved(recipe), toggleHeart: {
                                        if self.isRecipeSaved(recipe) {
                                            self.savedRecipes.removeAll(where: { $0.id == recipe.id })
                                        } else {
                                            self.savedRecipes.append(recipe)
                                        }
                                    })
                                }
                            }
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .background(
                Image("background")
                    .resizable()
                    .scaledToFill()
            )
        }
    }
    
    func isRecipeSaved(_ recipe: Recipe) -> Bool {
        return savedRecipes.contains { $0.id == recipe.id }
    }
}

// Filtered recipes menu
struct RecipeCategoryView: View {
    enum CategoryType {
        case antipasti, primi, secondi, dolci
        
        var title: String {
            switch self {
            case .antipasti: return "Appetizers"
            case .primi: return "First Courses"
            case .secondi: return "Second Courses"
            case .dolci: return "Desserts"
            }
        }
    }
    
    @Binding var isHeartRed: Bool
    @Binding var savedRecipes: [Recipe]
    var recipes: [Recipe]
    var category: CategoryType
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(recipes) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe, isHeartRed: self.isRecipeSaved(recipe), toggleHeart: {
                        if self.isRecipeSaved(recipe) {
                            self.savedRecipes.removeAll(where: { $0.id == recipe.id })
                        } else {
                            self.savedRecipes.append(recipe)
                        }
                    })) {
                        RecipeCard(recipe: recipe, isHeartRed: self.isRecipeSaved(recipe), toggleHeart: {
                            if self.isRecipeSaved(recipe) {
                                self.savedRecipes.removeAll(where: { $0.id == recipe.id })
                            } else {
                                self.savedRecipes.append(recipe)
                            }
                        })
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding()
            }
            .navigationTitle(category.title)
        }
    }
    
    func isRecipeSaved(_ recipe: Recipe) -> Bool {
        return savedRecipes.contains { $0.id == recipe.id }
    }
}

// Top black menu buttons
struct CategoryButton: View {
    let title: String
    let imageName: String
    
    var body: some View {
        ZStack{
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .frame(width: 150, height: 90)
                .foregroundColor(.white)
                .background(Color.black)
                .cornerRadius(30)
                .font(.largeTitle)
            
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 90)
                .cornerRadius(30)
                .clipped()
                .opacity(0.4)
        }
    }
}

// Favourite rcipes view
struct SavedRecipesView: View {
    @Binding var savedRecipes: [Recipe]
    
    var body: some View {
        ScrollView {
            HStack {
                Text("Favourites")
                    .font(.system(size: 40))
                    .fontWeight(.black)
                    .foregroundColor(.yellow)
                Spacer()
            }.padding()
            
            if savedRecipes.isEmpty {
                Text("Press the heart on the recipes to add favourites")
                    .font(.system(size: 30))
                    .foregroundColor(.gray)
                    .padding()
                    .multilineTextAlignment(.center)
            } else {
                VStack {
                    ForEach(savedRecipes) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipe: recipe, isHeartRed: self.isRecipeSaved(recipe), toggleHeart: {
                            if self.isRecipeSaved(recipe) {
                                self.savedRecipes.removeAll(where: { $0.id == recipe.id })
                            } else {
                                self.savedRecipes.append(recipe)
                            }
                        }))  {
                            RecipeCard(recipe: recipe, isHeartRed: self.isRecipeSaved(recipe), toggleHeart: {
                                if self.isRecipeSaved(recipe) {
                                    self.savedRecipes.removeAll(where: { $0.id == recipe.id })
                                } else {
                                    self.savedRecipes.append(recipe)
                                }
                            })
                        }
                    }
                    .padding()
                }.navigationTitle("Ricette Salvate")
            }
        }
    }
    func isRecipeSaved(_ recipe: Recipe) -> Bool {
        return savedRecipes.contains { $0.id == recipe.id }
    }
}

// Search bar
struct SearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            TextField("Search Recipes", text: $searchText)
                .padding(7)
                .padding(.leading, 30)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
            
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.leading, 15)
        }
    }
}

// Recipes clickable cards
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

// Recipes details (4 yellow squares)
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
                    .frame(width: 37, height: 37)
                Text(value)
                    .fontWeight(.black)
                    .font(.system(size: 23))
                Spacer()
            }
            Text(label)
                .fontWeight(.heavy)
                .padding(.bottom, 5)
                .font(.system(size: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(10)
        .background(Color.yellow)
        .cornerRadius(10)
    }
}

// Recipe full page
struct RecipeDetailView: View {
    @StateObject private var watchConnector:WatchConnector = WatchConnector()
    
    var recipe: Recipe
    var isHeartRed: Bool
    var toggleHeart: () -> Void
    
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
                        
                        VStack{
                            HStack{
                                Spacer()
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
                            Spacer()
                        }
                    }
                    
                    VStack{
                        HStack {
                            VStack(spacing: 10) {
                                HStack(spacing: 10) {
                                    RecipePropertyView(imageName: "frying.pan", value: "\(recipe.difficulty)", label: "Difficulty")
                                    RecipePropertyView(imageName: "person", value: "\(recipe.servingSize)", label: "Serving")
                                }
                                HStack(spacing: 10) {
                                    RecipePropertyView(imageName: "timer", value: "\(recipe.time)m", label: "Time")
                                    RecipePropertyView(imageName: "dollarsign.circle", value: "\(recipe.cost)", label: "Cost")
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
                                    .cornerRadius(3)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 3)
                                            .stroke(Color.yellow, lineWidth: 4)
                                    )
                                    .shadow(radius: 3)
                            }
                        }
                        Button(action: {
                            watchConnector.sendMessage(key: "testo", value: recipe.title)
                        }) {
                            Text("Cook")
                                .foregroundColor(.white)
                                .font(.system(size: 17))
                                .fontWeight(.black)
                                .padding()
                                .cornerRadius(3)
                                .background(Color.yellow)
                                .shadow(radius: 3)
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }
            Spacer().frame(height: 25)
        }
    }
}

// Recipes Steps 
struct instructionsView: View {
    var recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(recipe.instructions.indices, id: \.self) { index in
                    let stepNumber = index + 1
                    let instruction = recipe.instructions[index]
                    VStack(alignment: .leading) {
                        Text("Step \(stepNumber)")
                            .font(.system(size: 25))
                            .fontWeight(.black)
                            .foregroundColor(.yellow)
                        Text(instruction.text)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                        Divider()
                    }
                    .padding([.bottom, .top], 5)
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
