import Foundation
import SwiftUI

class RecipeManager: ObservableObject {
    @Published var savedRecipes: [Recipe] = []
    
    private let key = "savedRecipes"
    
    init() {
        loadSavedRecipes()
        
        NotificationCenter.default.addObserver(self, selector: #selector(saveRecipesIfNeeded), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func loadSavedRecipes() {
        if let data = UserDefaults.standard.data(forKey: key) {
            if let decoded = try? JSONDecoder().decode([Recipe].self, from: data) {
                savedRecipes = decoded
            }
        }
    }
    
    func saveRecipes() {
        if let encoded = try? JSONEncoder().encode(savedRecipes) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    @objc func saveRecipesIfNeeded() {
        saveRecipes()
    }
    
    func addRecipe(_ recipe: Recipe) {
        savedRecipes.append(recipe)
        saveRecipes()
    }
    
    func deleteRecipe(_ recipe: Recipe) {
        savedRecipes.removeAll { $0.id == recipe.id }
        saveRecipes()
    }
}
