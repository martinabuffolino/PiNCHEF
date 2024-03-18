import SwiftUI

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Tab bar and random function
struct ContentView: View {
    @State private var isHeartRed = false
    @StateObject private var recipeManager = RecipeManager()
    @State private var randomRecipes: [Recipe] = []
    
    @StateObject private var watchConnector:WatchConnector = WatchConnector()
    
    var body: some View {
        
            TabView {
                HomeView(isHeartRed: $isHeartRed
                         , randomRecipes: $randomRecipes, allRecipes: allRecipes, recipeManager: recipeManager)
                    .tabItem {
                        Label("Cook", systemImage: "text.book.closed.fill")
                    }
                SavedRecipesView(recipeManager: recipeManager)
                    .tabItem {
                        Label("Saved", systemImage: "heart")
                    }
            }
            .accentColor(.yellow)
        
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
