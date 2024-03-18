import SwiftUI

struct SavedRecipesView: View {
    @ObservedObject var recipeManager: RecipeManager
    
    @StateObject private var watchConnector: WatchConnector = WatchConnector()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        Text("Favorites")
                            .font(.system(size: 40))
                            .fontWeight(.black)
                            .foregroundColor(.yellow)
                        Spacer()
                    }
                    .padding()
                    
                    if recipeManager.savedRecipes.isEmpty {
                        Text("Press the heart on the recipes to add favorites")
                            .font(.system(size: 30))
                            .foregroundColor(.gray)
                            .padding()
                            .multilineTextAlignment(.center)
                    } else {
                        VStack {
                            ForEach(recipeManager.savedRecipes) { recipe in
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
        recipeManager.savedRecipes.contains { $0.id == recipe.id }
    }
    
    func toggleRecipeSaved(_ recipe: Recipe) {
        if isRecipeSaved(recipe) {
            recipeManager.deleteRecipe(recipe)
        } else {
            recipeManager.savedRecipes.append(recipe)
            recipeManager.saveRecipes()
        }
    }
}
