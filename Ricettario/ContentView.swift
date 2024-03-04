import SwiftUI

struct ContentView: View {
    @State private var isHeartRed = false
    @State private var savedRecipes = [Recipe]()
    @State private var randomRecipes: [Recipe] = []
    
//    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            TabView {
                HomeView(isHeartRed: $isHeartRed, savedRecipes: $savedRecipes, randomRecipes: $randomRecipes, antipastiRecipes: antipastiRecipes, primiRecipes: primiRecipes, secondiRecipes: secondiRecipes, dolciRecipes: dolciRecipes)
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

struct HomeView: View {
    @Binding var isHeartRed: Bool
    @Binding var savedRecipes: [Recipe]
    @Binding var randomRecipes: [Recipe]
    
    let antipastiRecipes: [Recipe]
    let primiRecipes: [Recipe]
    let secondiRecipes: [Recipe]
    let dolciRecipes: [Recipe]
    
//    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("What do you want to eat today?")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title)
                    .fontWeight(.light)
                    .padding(10)
                
                SearchBar()
                
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
                
                Text("RECIPES OF THE DAY")
                    .font(.title)
                    .fontWeight(.light)
                    .padding(.top, 10)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        Spacer()
                        ForEach(randomRecipes) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                RecipeCard(recipe: recipe, isHeartRed: self.isRecipeSaved(recipe), toggleHeart: {
                                    if self.isRecipeSaved(recipe) {
                                        self.savedRecipes.removeAll(where: { $0.title == recipe.title })
                                    } else {
                                        self.savedRecipes.append(recipe)
                                    }
                                })
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .background(Color.white)
        }
    }
    
    func isRecipeSaved(_ recipe: Recipe) -> Bool {
        return savedRecipes.contains { $0.id == recipe.id }
    }
}

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
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
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
                        NavigationLink(destination: RecipeDetailView(recipe: recipe))  {
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


struct SearchBar: View {
    @State private var searchText = ""
    
    var body: some View {
        ZStack(alignment: .leading) {
            TextField("Cerca ricetta", text: $searchText)
                .padding(7)
                .padding(.leading, 30)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 15)
            
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.leading, 15)
        }
    }
}

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

struct RecipeDetailView: View {
    @StateObject private var watchConnector:WatchConnector = WatchConnector()
    
    var recipe: Recipe
    
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
