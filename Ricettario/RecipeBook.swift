//
//  RecipeBook.swift
//  Ricettario
//
//  Created by Gabriel Amore on 21/02/24.
//



import Foundation

struct Ingredient {
    let name: String
    let quantity: String
}

struct Step {
    let type: String
    let text: String
}

struct Recipe: Identifiable {
    let id: String
    let title: String
    let ingredients: [Ingredient]
    let instructions: [Step]
    let imageName: String
    let description: String
    let isHeartRed: Bool
    
    let difficulty: Int
    let time: Int
    let cost: Int
    let servingSize: Int
    
    init(title: String, ingredients: [Ingredient], instructions: [Step], imageName: String, description: String, isHeartRed: Bool, difficulty: Int, time: Int, cost: Int, servingSize: Int) {
            self.id = title
            self.title = title
            self.ingredients = ingredients
            self.instructions = instructions
            self.imageName = imageName
            self.description = description
            self.isHeartRed = isHeartRed
            self.difficulty = difficulty
            self.time = time
            self.cost = cost
            self.servingSize = servingSize
        }
}

var antipastiRecipes: [Recipe] = [
    Recipe(title: "Classic Pancakes",
           ingredients: [
                Ingredient(name: "All-purpose flour", quantity: "1 cup"),
                Ingredient(name: "Granulated sugar", quantity: "2 tablespoons"),
                Ingredient(name: "Baking powder", quantity: "2 teaspoons"),
                Ingredient(name: "Salt", quantity: "1/2 teaspoon"),
                Ingredient(name: "Milk", quantity: "1 cup"),
                Ingredient(name: "Unsalted butter, melted", quantity: "2 tablespoons"),
                Ingredient(name: "Large egg", quantity: "1"),
                Ingredient(name: "Vanilla extract", quantity: "1 teaspoon"),
           ],
           instructions: [
                Step(type: "Mixing", text: "In a large bowl, whisk together the flour, sugar, baking powder, and salt."),
                Step(type: "Mixing", text: "In another bowl, whisk together the milk, melted butter, egg, and vanilla extract."),
                Step(type: "Combining", text: "Pour the wet ingredients into the dry ingredients and stir until just combined."),
                Step(type: "Cooking", text: "Heat a lightly oiled griddle or frying pan over medium-high heat."),
                Step(type: "Cooking", text: "Pour or scoop the batter onto the griddle, using approximately 1/4 cup for each pancake."),
                Step(type: "Cooking", text: "Cook until bubbles form on the surface, then flip with a spatula and cook until golden brown on the other side."),
                Step(type: "Serving", text: "Serve hot with your favorite toppings, such as maple syrup, fresh fruit, or whipped cream.")
           ],
           imageName: "pancake",
           description: "Classic fluffy pancakes that are perfect for breakfast or brunch.",
           isHeartRed: false,
           difficulty: 1,
           time: 10,
           cost: 1,
           servingSize: 4),
    
    Recipe(title: "Blueberry Muffins",
           ingredients: [
                Ingredient(name: "All-purpose flour", quantity: "2 cups"),
                Ingredient(name: "Granulated sugar", quantity: "1/2 cup"),
                Ingredient(name: "Baking powder", quantity: "2 teaspoons"),
                Ingredient(name: "Salt", quantity: "1/2 teaspoon"),
                Ingredient(name: "Milk", quantity: "1/2 cup"),
                Ingredient(name: "Vegetable oil", quantity: "1/4 cup"),
                Ingredient(name: "Large egg", quantity: "1"),
                Ingredient(name: "Vanilla extract", quantity: "1 teaspoon"),
                Ingredient(name: "Fresh blueberries", quantity: "1 cup"),
           ],
           instructions: [
                Step(type: "Mixing", text: "Preheat oven to 375°F (190°C). Line a muffin tin with paper liners or grease with non-stick cooking spray."),
                Step(type: "Mixing", text: "In a large bowl, whisk together the flour, sugar, baking powder, and salt."),
                Step(type: "Mixing", text: "In another bowl, whisk together the milk, vegetable oil, egg, and vanilla extract."),
                Step(type: "Combining", text: "Pour the wet ingredients into the dry ingredients and stir until just combined. Gently fold in the fresh blueberries."),
                Step(type: "Filling", text: "Scoop the batter into the prepared muffin tin, filling each cup about two-thirds full."),
                Step(type: "Baking", text: "Bake in the preheated oven for 18-20 minutes, or until a toothpick inserted into the center of a muffin comes out clean."),
                Step(type: "Cooling", text: "Remove from the oven and allow the muffins to cool in the tin for 5 minutes before transferring to a wire rack to cool completely."),
           ],
           imageName: "muffin",
           description: "Delicious and moist blueberry muffins bursting with fresh blueberries, perfect for breakfast or a snack.",
           isHeartRed: false,
           difficulty: 2,
           time: 25,
           cost: 2,
           servingSize: 12)
]

var primiRecipes: [Recipe] = []

var secondiRecipes: [Recipe] = []

var dolciRecipes: [Recipe] = [
    

]

// Unisci tutte le ricette in un'unica array
var allRecipes: [Recipe] = antipastiRecipes + primiRecipes + secondiRecipes + dolciRecipes

var savedRecipes: [Recipe] = []
