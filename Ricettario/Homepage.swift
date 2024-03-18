import Foundation
import SwiftUI

// Homepage
struct HomeView: View {
    @StateObject private var watchConnector: WatchConnector = WatchConnector()
    
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
                    Spacer()
                    SearchBar(searchText: $searchText)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            CategoryButton(title: "Appetizers", imageName: "appetizers", destination: RecipeCategoryView(isHeartRed: $isHeartRed, recipeManager: recipeManager, recipes: appetizersRecipes, category: .appetizers))
                            CategoryButton(title: "First Courses", imageName: "first_course", destination: RecipeCategoryView(isHeartRed: $isHeartRed, recipeManager: recipeManager, recipes: first_coursesRecipes, category: .first_courses))
                            CategoryButton(title: "Second Courses", imageName: "second_course", destination: RecipeCategoryView(isHeartRed: $isHeartRed, recipeManager: recipeManager, recipes: second_coursesRecipes, category: .second_courses))
                            CategoryButton(title: "Desserts", imageName: "desserts", destination: RecipeCategoryView(isHeartRed: $isHeartRed, recipeManager: recipeManager, recipes: dessertsRecipes, category: .desserts))
                        }.padding()
                    }
                    
                    Text(searchText.isEmpty ? "RECIPES OF THE DAY" : "RESULTS").font(.title).fontWeight(.semibold).padding(10)
                    
                    if filteredRecipes.isEmpty && !searchText.isEmpty {
                        Text("No results found for '\(searchText)'")
                            .foregroundColor(.black)
                            .padding(.bottom, 10)
                    } else {
                        VStack(spacing: 20) {
                            ForEach(searchText.isEmpty ? randomRecipes : filteredRecipes) { recipe in
                                RecipeCard(recipe: recipe, isHeartRed: self.isRecipeSaved(recipe), toggleHeart: {
                                    if self.isRecipeSaved(recipe) {
                                        self.recipeManager.deleteRecipe(recipe)
                                    } else {
                                        self.recipeManager.addRecipe(recipe)
                                    }
                                })
                                
                            }
                        }
//                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .background(Image("background").resizable().scaledToFill())
            .navigationTitle("Recipe Book")
            .toolbarBackground(.yellow, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)

        }
        .tint(.black)
    }
    
    func isRecipeSaved(_ recipe: Recipe) -> Bool {
        recipeManager.savedRecipes.contains { $0.id == recipe.id }
    }
}
