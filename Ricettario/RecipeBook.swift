import Foundation

struct Ingredient {
    let name: String
    let quantity: String
}

struct Step: Codable {
    let type: String
    let text: String
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

var allRecipes: [Recipe] = antipastiRecipes + primiRecipes + secondiRecipes + dolciRecipes

var savedRecipes: [Recipe] = []

var antipastiRecipes: [Recipe] = [
    Recipe(title: "French Fries",
           ingredients: [
                Ingredient(name: "Potatoes", quantity: "2 large"),
                Ingredient(name: "Vegetable oil", quantity: "2 cups"),
                Ingredient(name: "Salt", quantity: "1 tsp"),
                Ingredient(name: "Black pepper", quantity: "1/2 tsp"),
                Ingredient(name: "Paprika (optional)", quantity: "1/2 tsp"),
           ],
           instructions: [
                Step(type: "Preparation", text: "Peel the potatoes and cut them into evenly-sized sticks, about 1/4 inch thick."),
                Step(type: "Soaking", text: "Soak the potato sticks in cold water for at least 30 minutes to remove excess starch."),
                Step(type: "Drying", text: "Drain the potatoes and pat them dry with paper towels to remove excess moisture."),
                Step(type: "Frying", text: "Heat vegetable oil in a deep fryer or large pot to 325°F (160°C)."),
                Step(type: "Frying", text: "Working in batches, carefully add the potato sticks to the hot oil and fry for 5-6 minutes, until pale golden and slightly softened."),
                Step(type: "Draining", text: "Remove the partially cooked fries from the oil and drain them on paper towels."),
                Step(type: "Frying", text: "Increase the oil temperature to 375°F (190°C)."),
                Step(type: "Frying", text: "Return the fries to the hot oil in batches and fry for an additional 2-3 minutes, until golden brown and crispy."),
                Step(type: "Seasoning", text: "Transfer the fries to a large bowl and immediately season with salt, black pepper, and paprika (if using). Toss to coat evenly."),
                Step(type: "Serving", text: "Serve hot, optionally with ketchup, mayonnaise, or your favorite dipping sauce."),
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
                Step(type: "Preparation", text: "Peel the potatoes and grate them using a box grater or food processor. Place the grated potatoes in a clean kitchen towel and squeeze out excess moisture."),
                Step(type: "Mixing", text: "In a large bowl, combine the grated potatoes, chopped onion, garlic powder, salt, and black pepper. Mix well to combine."),
                Step(type: "Forming", text: "Take small portions of the potato mixture and shape them into small cylindrical tots using your hands."),
                Step(type: "Frying", text: "Heat vegetable oil in a deep fryer or large pot to 350°F (175°C)."),
                Step(type: "Frying", text: "Working in batches, carefully add the tater tots to the hot oil and fry for 3-4 minutes, until golden brown and crispy."),
                Step(type: "Draining", text: "Remove the fried tater tots from the oil and drain them on paper towels."),
                Step(type: "Seasoning", text: "Sprinkle with additional salt, if desired, and serve hot."),
           ],
           imageName: "tater_tots",
           description: "Homemade tater tots that are crispy on the outside and soft on the inside, perfect as a snack or side dish.",
           isHeartRed: false,
           difficulty: .medium,
           time: 30,
           cost: .low,
           servingSize: 4)

]

var primiRecipes: [Recipe] = [
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
                Step(type: "Cooking", text: "Heat olive oil in a saucepan over medium heat."),
                Step(type: "Cooking", text: "Add chopped onion and minced garlic. Cook until softened, about 5 minutes."),
                Step(type: "Cooking", text: "Pour in canned tomatoes. Break them up with a spoon."),
                Step(type: "Seasoning", text: "Add dried oregano, salt, and black pepper."),
                Step(type: "Simmering", text: "Bring to a simmer. Cook for 20-25 minutes, stirring occasionally, until sauce thickens."),
                Step(type: "Finishing", text: "Taste and adjust seasoning if needed."),
                Step(type: "Serving", text: "Serve over cooked pasta or use as a base for pizza."),
           ],
           imageName: "sauce_pasta",
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
                Step(type: "Cooking", text: "Cook spaghetti according to package instructions until al dente."),
                Step(type: "Preparation", text: "In a large skillet, heat olive oil from the tuna can over medium heat."),
                Step(type: "Cooking", text: "Add minced garlic and cook until fragrant, about 1 minute."),
                Step(type: "Cooking", text: "Add cherry tomatoes and cook until they start to soften, about 2 minutes."),
                Step(type: "Cooking", text: "Add canned tuna with its oil to the skillet. Break up the tuna into smaller pieces with a spoon."),
                Step(type: "Seasoning", text: "Season with salt, black pepper, and red pepper flakes (if using)."),
                Step(type: "Combining", text: "Add cooked spaghetti to the skillet. Toss to combine with the sauce and heat through."),
                Step(type: "Finishing", text: "Drizzle lemon juice over the pasta and sprinkle with chopped parsley. Toss once more before serving."),
                Step(type: "Serving", text: "Serve hot, optionally garnished with additional parsley and lemon wedges."),
           ],
           imageName: "tuna_spaghetti",
           description: "A quick and flavorful pasta dish made with spaghetti, canned tuna, garlic, cherry tomatoes, and fresh parsley.",
           isHeartRed: false,
           difficulty: .easy,
           time: 20,
           cost: .medium,
           servingSize: 2)
]

var secondiRecipes: [Recipe] = [
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
                Step(type: "Preparation", text: "Season the beef chuck steak with salt and black pepper on both sides."),
                Step(type: "Searing", text: "Heat vegetable oil in a large skillet over medium-high heat. Add the steak and sear until browned on both sides, about 4-5 minutes per side. Remove the steak from the skillet and set aside."),
                Step(type: "Sauteing", text: "In the same skillet, add sliced onion and minced garlic. Cook until softened, about 3-4 minutes."),
                Step(type: "Deglazing", text: "Pour beef broth into the skillet, scraping up any browned bits from the bottom of the pan."),
                Step(type: "Adding Flavor", text: "Stir in Worcestershire sauce, Dijon mustard, and fresh thyme sprigs."),
                Step(type: "Braising", text: "Return the seared steak to the skillet. Bring the liquid to a simmer, then cover and reduce the heat to low. Let the steak simmer for 2-2.5 hours, or until tender, turning occasionally."),
                Step(type: "Finishing", text: "Once the steak is tender, remove it from the skillet and let it rest for a few minutes before slicing."),
                Step(type: "Serving", text: "Serve the sliced braised steak with the onion gravy spooned over the top."),
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
                Step(type: "Preparation", text: "Slice the seitan into thin cutlets, about 1/2 inch thick."),
                Step(type: "Breading", text: "In a shallow dish, combine breadcrumbs, nutritional yeast, garlic powder, onion powder, salt, and black pepper."),
                Step(type: "Coating", text: "In another shallow dish, place all-purpose flour. In a third shallow dish, pour plant-based milk."),
                Step(type: "Dredging", text: "Dredge each seitan cutlet in flour, then dip it into the plant-based milk, and finally coat it with the breadcrumb mixture, pressing gently to adhere."),
                Step(type: "Frying", text: "Heat vegetable oil in a large skillet over medium heat. Add the breaded seitan cutlets to the skillet and fry until golden brown and crispy on both sides, about 3-4 minutes per side."),
                Step(type: "Draining", text: "Remove the fried cutlets from the skillet and place them on a plate lined with paper towels to drain excess oil."),
                Step(type: "Serving", text: "Serve the vegan cotoletta hot, optionally garnished with lemon wedges and fresh herbs. Enjoy with your favorite side dishes or sauces."),
           ],
           imageName: "cotoletta",
           description: "A vegan twist on the classic Italian cotoletta, made with seitan cutlets breaded and fried until crispy and golden brown.",
           isHeartRed: false,
           difficulty: .medium,
           time: 30,
           cost: .high,
           servingSize: 4)
]

var dolciRecipes: [Recipe] = [
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
           difficulty: .medium,
           time: 25,
           cost: .medium,
           servingSize: 12)
]
