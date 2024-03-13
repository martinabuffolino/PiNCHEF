import SwiftUI

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Tab bar and random function
struct ContentView: View {
    @State private var isHeartRed = false
    @State private var savedRecipes = [Recipe]()
    @State private var randomRecipes: [Recipe] = []
    
    @StateObject private var watchConnector:WatchConnector = WatchConnector()
    
    var body: some View {
        NavigationView {
            TabView {
                HomeView(isHeartRed: $isHeartRed, savedRecipes: $savedRecipes, randomRecipes: $randomRecipes, allRecipes: allRecipes)
                    .tabItem {
                        Label("Cook", systemImage: "text.book.closed.fill")
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
    @StateObject private var watchConnector:WatchConnector = WatchConnector()
    
    @Binding var isHeartRed: Bool
    @Binding var savedRecipes: [Recipe]
    @Binding var randomRecipes: [Recipe]
    @State private var searchText: String = ""
    
    let allRecipes: [Recipe]
    
    var filteredRecipes: [Recipe] {
        searchText.isEmpty ? randomRecipes : allRecipes.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }
    
//    init() {
//        UITableView.appearance().bar
//    }
    
    var body: some View {
            
            NavigationStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0){
                        //                HStack {
                        //                    Text().font(.system(size: 40)).fontWeight(.black).padding()
                        //                    Spacer()
                        //                }
                        //                SearchBar(searchText: $searchText)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                CategoryButton(title: "Appetizers", imageName: "appetizers", destination: RecipeCategoryView(isHeartRed: $isHeartRed, savedRecipes: $savedRecipes, recipes: appetizersRecipes, category: .appetizers))
                                CategoryButton(title: "First Courses", imageName: "first_course", destination: RecipeCategoryView(isHeartRed: $isHeartRed, savedRecipes: $savedRecipes, recipes: first_cousesRecipes, category: .first_couses))
                                CategoryButton(title: "Second Courses", imageName: "second_course", destination: RecipeCategoryView(isHeartRed: $isHeartRed, savedRecipes: $savedRecipes, recipes: second_coursesRecipes, category: .second_courses))
                                CategoryButton(title: "Desserts", imageName: "desserts", destination: RecipeCategoryView(isHeartRed: $isHeartRed, savedRecipes: $savedRecipes, recipes: dessertsRecipes, category: .desserts))
                            }.padding()
                        }
                        
                        
                        VStack {
                            Text(searchText.isEmpty ? "RECIPES OF THE DAY" : "RESULTS").font(.title).fontWeight(.semibold).padding(.top, 10)
                            ForEach(searchText.isEmpty ? randomRecipes : filteredRecipes) { recipe in
                                RecipeCard(recipe: recipe, isHeartRed: self.isRecipeSaved(recipe), toggleHeart: {
                                    if self.isRecipeSaved(recipe) {
                                        self.savedRecipes.removeAll(where: { $0.id == recipe.id })
                                    } else {
                                        self.savedRecipes.append(recipe)
                                    }
                                })
                            }
                        }.buttonStyle(PlainButtonStyle())
                    }
                }.background(Image("background").resizable().scaledToFill())
                    .navigationTitle("Recipe Book")
                    .toolbarBackground(.yellow, for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .searchable(text: $searchText)
            }
        
    }
    
    func isRecipeSaved(_ recipe: Recipe) -> Bool {
        savedRecipes.contains { $0.id == recipe.id }
    }
}

struct RecipeCategoryView: View {
    enum CategoryType: String, CaseIterable {
        case appetizers = "Appetizers"
        case first_couses = "First Courses"
        case second_courses = "Second Courses"
        case desserts = "Desserts"
    }
    
    @Binding var isHeartRed: Bool
    @Binding var savedRecipes: [Recipe]
    
    var recipes: [Recipe]
    var category: CategoryType
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(recipes) { recipe in
                    RecipeCard(recipe: recipe, isHeartRed: self.isRecipeSaved(recipe), toggleHeart: {
                        self.toggleRecipeSaved(recipe)
                    })
                }
                .padding()
            }
            .navigationTitle(category.rawValue)
        }
    }
    
    func isRecipeSaved(_ recipe: Recipe) -> Bool {
        savedRecipes.contains { $0.id == recipe.id }
    }
    
    func toggleRecipeSaved(_ recipe: Recipe) {
        if isRecipeSaved(recipe) {
            savedRecipes.removeAll { $0.id == recipe.id }
        } else {
            savedRecipes.append(recipe)
        }
    }
}


// Top black menu buttons
struct CategoryButton<Destination: View>: View {
    let title: String
    let imageName: String
    let destination: Destination
    
    var body: some View {
        NavigationLink(destination: destination) {
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
}

struct SavedRecipesView: View {
    @Binding var savedRecipes: [Recipe]
    
    @StateObject private var watchConnector:WatchConnector = WatchConnector()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Text("Favourites")
                            .font(.system(size: 40))
                            .fontWeight(.black)
                            .foregroundColor(.yellow)
                        Spacer()
                    }
                    .padding()
                    
                    if savedRecipes.isEmpty {
                        Text("Press the heart on the recipes to add favourites")
                            .font(.system(size: 30))
                            .foregroundColor(.gray)
                            .padding()
                            .multilineTextAlignment(.center)
                    } else {
                        VStack {
                            ForEach(savedRecipes) { recipe in
                                RecipeCard(recipe: recipe, isHeartRed: self.isRecipeSaved(recipe), toggleHeart: { self.toggleRecipeSaved(recipe) })
                            }
                            .padding()
                        }
                    }
                }
            }
        }
    }
    
    func isRecipeSaved(_ recipe: Recipe) -> Bool {
        savedRecipes.contains { $0.id == recipe.id }
    }
    
    func toggleRecipeSaved(_ recipe: Recipe) {
        if isRecipeSaved(recipe) {
            savedRecipes.removeAll { $0.id == recipe.id }
        } else {
            savedRecipes.append(recipe)
        }
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
    
    @StateObject private var watchConnector:WatchConnector = WatchConnector()
   
    @State private var isPopoverPresented = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topTrailing) {
                Image(recipe.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: 150)
                    .edgesIgnoringSafeArea(.horizontal)
                    .aspectRatio(4/3, contentMode: .fill)
                    .frame(height: 180)
                    .clipped()
                
                Button(action:  {
                    toggleHeart()
                    if(isHeartRed){
                        watchConnector.sendMessage(key: "rmvPref", value: recipe.title)}
                    else if (!isHeartRed){
                        watchConnector.sendMessage(key: "addPref", value: recipe.title)}
                }){
                    Image(systemName: isHeartRed ? "heart.fill" : "heart")
                        .foregroundColor(isHeartRed ? .red : .white)
                        .padding(8)
                        .background(Color.black.opacity(0.6))
                        .clipShape(Circle())
                        .padding(8)
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.title)
                    .font(.system(size: 25))
                    .fontWeight(.heavy)
                    .lineLimit(1)
                
                Text(recipe.description)
                    .foregroundColor(.gray)
                    .fontWeight(.semibold)
                    .font(.system(size: 15))
                    .lineLimit(3)
            }
            .padding(5)
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal)
        .onTapGesture {
            isPopoverPresented.toggle()
        }
        .popover(isPresented: $isPopoverPresented, arrowEdge: .bottom) {
            RecipeDetailView(recipe: recipe, isHeartRed: isHeartRed, toggleHeart: toggleHeart)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// Recipes details (4 yellow squares)
struct RecipePropertyView: View {
    var imageName: String
    var value: String
    var label: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
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
                .font(.system(size: 20))
        }
        .padding(10)
        .background(Color.yellow)
        .cornerRadius(10)
    }
}

// Recipe full page
struct RecipeDetailView: View {
    @StateObject private var watchConnector:WatchConnector = WatchConnector()
   
    @State var isInstructionsSheetPresented = false
    @State var selectedRecipe: Recipe? = nil
        
    var recipe: Recipe
    var isHeartRed: Bool
    var toggleHeart: () -> Void
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
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
                
                HStack{
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
                }
                Spacer().frame(height: 20)
                HStack(spacing: 20){
                    Spacer()
                    Button(action: {
                        self.isInstructionsSheetPresented.toggle()
                    }) {
                        Text("Instructions")
                            .font(.system(size: 14))
                            .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                            .foregroundColor(.yellow)
                            .frame(maxWidth: .infinity)
                            .background(.clear)
                            .clipShape(Capsule())
                            .overlay(
                                Capsule()
                                    .stroke(Color.yellow, lineWidth: 4)
                            )
                            .fontWeight(.black)
                    }

                    .popover(isPresented: $isInstructionsSheetPresented) {
                        GeometryReader { geometry in
                            VStack {
                                Spacer()
                                InstructionsPopover(recipe: recipe, isInstructionsPopoverPresented: $isInstructionsSheetPresented)
                                    }
                            }
                        }
                                                
                    Button(action: {
                        watchConnector.sendMessage(key: "testo", value: recipe.title)
                    }) {
                        Text("Cook")
                            .font(.system(size: 17))
                            .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .background(.yellow)
                            .clipShape(Capsule())
                            .fontWeight(.black)
                    }
                    Spacer()
                }
                Spacer()
            }
            Spacer().frame(height: 25)
        }
    }
}

// Recipes Steps
struct InstructionsPopover: View {
    var recipe: Recipe
    
    @Binding var isInstructionsPopoverPresented: Bool
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack{
                Text("Instructions")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.vertical, 10)
                Spacer()
                Button("✖") {
                    dismiss()
                }
            }
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(recipe.instructions.indices, id: \.self) { index in
                        let stepNumber = index + 1
                        let instruction = recipe.instructions[index]
                        VStack(alignment: .leading) {
                            HStack(alignment: .top) {
                                Text("\(stepNumber)")
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .foregroundColor(.yellow)
                                Text(instruction.text)
                                    .font(.system(size: 16))
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                                    .shadow(color: .gray, radius: 2)
                            )
                        }
                        .padding([.bottom, .top], 5)
                    }
                }
               
                .padding()
                
                
            }
            
        }
        .padding()
        .background(.yellow)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}
