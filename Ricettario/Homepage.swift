import Foundation
import SwiftUI

// Homepage
struct HomeView: View {
    @StateObject private var watchConnector:WatchConnector = WatchConnector()
    
    @Binding var isHeartRed: Bool
    @Binding var randomRecipes: [Recipe]
    @State private var searchText: String = ""
    
    let allRecipes: [Recipe]
    @ObservedObject var recipeManager: RecipeManager
    
    var filteredRecipes: [Recipe] {
        searchText.isEmpty ? randomRecipes : allRecipes.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0){
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            CategoryButton(title: "Appetizers", imageName: "appetizers", destination: RecipeCategoryView(isHeartRed: $isHeartRed, recipeManager: recipeManager, recipes: appetizersRecipes, category: .appetizers))
                            CategoryButton(title: "First Courses", imageName: "first_course", destination: RecipeCategoryView(isHeartRed: $isHeartRed, recipeManager: recipeManager, recipes: appetizersRecipes, category: .appetizers))
                            CategoryButton(title: "Second Courses", imageName: "second_course", destination: RecipeCategoryView(isHeartRed: $isHeartRed, recipeManager: recipeManager, recipes: second_coursesRecipes, category: .second_courses))
                            CategoryButton(title: "Desserts", imageName: "desserts", destination: RecipeCategoryView(isHeartRed: $isHeartRed, recipeManager: recipeManager, recipes: dessertsRecipes, category: .desserts))
                        }.padding()
                    }
                    
                    Text(searchText.isEmpty ? "RECIPES OF THE DAY" : "RESULTS").font(.title).fontWeight(.semibold).padding(10)
                    VStack(spacing: 20) {
                        ForEach(searchText.isEmpty ? randomRecipes : filteredRecipes) { recipe in
                            RecipeCard(recipe: recipe, isHeartRed: self.isRecipeSaved(recipe), toggleHeart: {
                                if self.isRecipeSaved(recipe) {
                                    self.recipeManager.deleteRecipe(recipe)
                                } else {
                                    self.recipeManager.savedRecipes.append(recipe)
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
        recipeManager.savedRecipes.contains { $0.id == recipe.id }
    }
}
