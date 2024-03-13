import SwiftUI

struct RecipeCategoryView: View {
    enum CategoryType: String, CaseIterable {
        case appetizers = "Appetizers"
        case first_courses = "First Courses"
        case second_courses = "Second Courses"
        case desserts = "Desserts"
    }
    
    @Binding var isHeartRed: Bool
    @ObservedObject var recipeManager: RecipeManager
    
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
        recipeManager.savedRecipes.contains { $0.id == recipe.id }
    }
    
    func toggleRecipeSaved(_ recipe: Recipe) {
        if isRecipeSaved(recipe) {
            recipeManager.deleteRecipe(recipe)
        } else {
            recipeManager.savedRecipes.append(recipe)
        }
    }
}
