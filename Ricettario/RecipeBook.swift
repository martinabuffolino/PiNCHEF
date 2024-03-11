import Foundation

struct Ingredient {
    let name: String
    let quantity: String
}

struct Step: Codable {
    let type: String
    let text: String
    var timer: Int? = nil
}

enum Difficulty: String {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
}

enum Cost: String {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}

struct Recipe: Identifiable {
    let id: String
    let title: String
    let ingredients: [Ingredient]
    let instructions: [Step]
    let imageName: String
    let description: String
    let isHeartRed: Bool
    
    let difficulty: Difficulty
    let time: Int
    let cost: Cost
    let servingSize: Int
    
    init(title: String, ingredients: [Ingredient], instructions: [Step], imageName: String, description: String, isHeartRed: Bool, difficulty: Difficulty, time: Int, cost: Cost, servingSize: Int) {
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

var allRecipes: [Recipe] = appetizersRecipes + first_cousesRecipes + second_coursesRecipes + dessertsRecipes

var savedRecipes: [Recipe] = []

var appetizersRecipes: [Recipe] = [
    Recipe(title: "French Fries",
           ingredients: [
                Ingredient(name: "Potatoes", quantity: "2 large"),
                Ingredient(name: "Vegetable oil", quantity: "2 cups"),
                Ingredient(name: "Salt", quantity: "1 tsp"),
                Ingredient(name: "Black pepper", quantity: "1/2 tsp"),
                Ingredient(name: "Paprika (optional)", quantity: "1/2 tsp"),
           ],
           instructions: [
                Step(type: "Cut", text: "Peel and cut the potatoes ."),
                Step(type: "Cook", text: "Heat vegetable oil to 160°C."),
                Step(type: "Wait", text: "Fry for 5-6 minutes.", timer: 60),
                Step(type: "Mix", text: "Season with salt and our favorite dipping sauce."),
           ],
           imageName: "fries",
           description: "Homemade French fries that are crispy on the outside and fluffy on the inside, perfect as a side dish or snack.",
           isHeartRed: false,
           difficulty: .easy,
           time: 60,
           cost: .low,
           servingSize: 4),
    
    Recipe(title: "Tater Tots",
           ingredients: [
                Ingredient(name: "Potatoes", quantity: "2 large"),
                Ingredient(name: "Onion, finely chopped", quantity: "1/2"),
                Ingredient(name: "Garlic powder", quantity: "1 tsp"),
                Ingredient(name: "Salt", quantity: "1 tsp"),
                Ingredient(name: "Black pepper", quantity: "1/2 tsp"),
                Ingredient(name: "Vegetable oil", quantity: "2 cups"),
           ],
           instructions: [
                Step(type: "Cut", text: "Peel and grate the potatoes."),
                Step(type: "Mix", text: "Mix the grated potatoes, chopped onion, garlic powder, salt, and black pepper."),
                Step(type: "Cook", text: "Heat vegetable oil to 175°C."),
                Step(type: "Wait", text: "Fry for 3-4 minutes."),
           ],
           imageName: "tater_tots",
           description: "Homemade tater tots that are crispy on the outside and soft on the inside, perfect as a snack or side dish.",
           isHeartRed: false,
           difficulty: .medium,
           time: 30,
           cost: .low,
           servingSize: 4)

]

var first_cousesRecipes: [Recipe] = [
    Recipe(title: "Tomato Sauce",
           ingredients: [
                Ingredient(name: "Canned whole tomatoes", quantity: "28 oz"),
                Ingredient(name: "Olive oil", quantity: "2 tbsp"),
                Ingredient(name: "Onion, chopped", quantity: "1"),
                Ingredient(name: "Garlic, minced", quantity: "2 cloves"),
                Ingredient(name: "Dried oregano", quantity: "1 tsp"),
                Ingredient(name: "Salt", quantity: "1/2 tsp"),
                Ingredient(name: "Black pepper", quantity: "1/4 tsp"),
           ],
           instructions: [
                Step(type: "Wait", text: "Heat olive oil over medium heat."),
                Step(type: "Add", text: "Add onion and garlic and cook about 5 minutes."),
                Step(type: "Add", text: "Pour in canned tomatoes."),
                Step(type: "Add", text: "Add dried oregano, salt, and black pepper."),
                Step(type: "Cook", text: "Cook for 20-25 minutes."),
           ],
           imageName: "tomato",
           description: "A quick and easy tomato sauce made with canned tomatoes, onion, garlic, and herbs.",
           isHeartRed: false,
           difficulty: .easy,
           time: 30,
           cost: .low,
           servingSize: 4),
    
    Recipe(title: "Spaghetti with Tuna",
           ingredients: [
                Ingredient(name: "Spaghetti", quantity: "8 oz"),
                Ingredient(name: "Canned tuna in olive oil", quantity: "1 can (5 oz)"),
                Ingredient(name: "Garlic cloves, minced", quantity: "2"),
                Ingredient(name: "Cherry tomatoes, halved", quantity: "1 cup"),
                Ingredient(name: "Fresh parsley, chopped", quantity: "2 tbsp"),
                Ingredient(name: "Lemon juice", quantity: "1 tbsp"),
                Ingredient(name: "Salt", quantity: "1/2 tsp"),
                Ingredient(name: "Black pepper", quantity: "1/4 tsp"),
                Ingredient(name: "Red pepper flakes (optional)", quantity: "1/4 tsp"),
           ],
           instructions: [
                Step(type: "Cook", text: "Cook spaghetti according to package instructions."),
                Step(type: "Cook", text: "Heat olive oil over medium heat."),
                Step(type: "Add", text: "Add garlic and cook about 1 minute."),
                Step(type: "Add", text: "Add cherry tomatoes and cook about 2 minutes."),
                Step(type: "Add", text: "Add canned tuna."),
                Step(type: "Mix", text: "Season with salt, black pepper, and red pepper flakes."),
                Step(type: "Add", text: "Add cooked spaghetti."),
           ],
           imageName: "tuna_spaghetti",
           description: "A quick and flavorful pasta dish made with spaghetti, canned tuna, garlic, cherry tomatoes, and fresh parsley.",
           isHeartRed: false,
           difficulty: .easy,
           time: 20,
           cost: .medium,
           servingSize: 2)
]

var second_coursesRecipes: [Recipe] = [
    Recipe(title: "Braised Steak",
           ingredients: [
                Ingredient(name: "Beef chuck steak", quantity: "2 lbs"),
                Ingredient(name: "Vegetable oil", quantity: "2 tbsp"),
                Ingredient(name: "Onion, sliced", quantity: "1"),
                Ingredient(name: "Garlic cloves, minced", quantity: "2"),
                Ingredient(name: "Beef broth", quantity: "2 cups"),
                Ingredient(name: "Worcestershire sauce", quantity: "2 tbsp"),
                Ingredient(name: "Dijon mustard", quantity: "1 tbsp"),
                Ingredient(name: "Fresh thyme sprigs", quantity: "2"),
                Ingredient(name: "Salt", quantity: "1 tsp"),
                Ingredient(name: "Black pepper", quantity: "1/2 tsp"),
           ],
           instructions: [
                Step(type: "Add", text: "Season the beef chuck steak with salt and black pepper."),
                Step(type: "Cook", text: "Heat vegetable oil over medium-high heat."),
                Step(type: "Cook", text: "Cook the steak for 4-5 minutes then take out."),
                Step(type: "Cook", text: "Cook onion and garlic for 3-4 minutes."),
                Step(type: "Add", text: "Add Worcestershire sauce, Dijon mustard, and fresh thyme sprigs."),
                Step(type: "Cook", text: "Let the steak simmer for 2-2.5 hours."),
           ],
           imageName: "braised_steak",
           description: "Tender and flavorful beef chuck steak braised in a savory onion gravy, perfect for a comforting meal.",
           isHeartRed: false,
           difficulty: .hard,
           time: 150,
           cost: .high,
           servingSize: 4),
    
    Recipe(title: "Vegan Cotoletta",
           ingredients: [
                Ingredient(name: "Seitan", quantity: "2 cups"),
                Ingredient(name: "Breadcrumbs", quantity: "1 cup"),
                Ingredient(name: "Nutritional yeast", quantity: "1/4 cup"),
                Ingredient(name: "Garlic powder", quantity: "1 tsp"),
                Ingredient(name: "Onion powder", quantity: "1 tsp"),
                Ingredient(name: "Salt", quantity: "1/2 tsp"),
                Ingredient(name: "Black pepper", quantity: "1/4 tsp"),
                Ingredient(name: "All-purpose flour", quantity: "1/2 cup"),
                Ingredient(name: "Plant-based milk", quantity: "1 cup"),
                Ingredient(name: "Vegetable oil", quantity: "1/4 cup"),
           ],
           instructions: [
                Step(type: "Cut", text: "Slice the seitan cutlets into thin cutlets."),
                Step(type: "Mix", text: "Combine breadcrumbs, nutritional yeast, garlic powder, onion powder, salt, and black pepper."),
                Step(type: "Mix", text: "Dredge seitan cutlet in flour, then into the plant-based milk, and finally into the breadcrumb."),
                Step(type: "Cook", text: "Heat vegetable oil over medium heat."),
                Step(type: "Coook", text: "Fry the seitan cutlets about 3-4 minutes"),
           ],
           imageName: "cotoletta",
           description: "A vegan twist on the classic Italian cotoletta, made with seitan cutlets breaded and fried until crispy and golden brown.",
           isHeartRed: false,
           difficulty: .medium,
           time: 30,
           cost: .high,
           servingSize: 4)
]

var dessertsRecipes: [Recipe] = [
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
                Step(type: "Mix", text: "Whisk the flour, sugar, baking powder, and salt."),
                Step(type: "Mix", text: "In another bowl, whisk the milk, melted butter, egg, and vanilla extract."),
                Step(type: "Mix", text: "Mix the ingredients."),
                Step(type: "Cook", text: "Heat a griddle over medium-high heat."),
                Step(type: "Add", text: "Pour the batter onto the griddle."),
                Step(type: "Cook", text: "Cook until bubbles form on the surface and then flip on the other side."),
           ],
           imageName: "pancake",
           description: "Classic fluffy pancakes that are perfect for breakfast or brunch.",
           isHeartRed: false,
           difficulty: .medium,
           time: 10,
           cost: .low,
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
                Step(type: "Cook", text: "Preheat oven to 190°C."),
                Step(type: "Mix", text: "Whisk the flour, sugar, baking powder, and salt."),
                Step(type: "Mix", text: "In another bowl, whisk the milk, vegetable oil, egg, and vanilla extract."),
                Step(type: "Mix", text: "Mix the ingredients."),
                Step(type: "Add", text: "Scoop the batter into the prepared muffin tin."),
                Step(type: "Cook", text: "Bake in the preheated oven for 18-20 minutes."),
           ],
           imageName: "muffin",
           description: "Delicious and moist blueberry muffins bursting with fresh blueberries, perfect for breakfast or a snack.",
           isHeartRed: false,
           difficulty: .medium,
           time: 25,
           cost: .medium,
           servingSize: 12)
]
