//
//  ContentView.swift
//  Ricettario
//
//  Created by Martina Buffissima on 19/02/24.
//
// 
import SwiftUI

// Struttura elenco ricette
struct RecipeDetailView: View {
    var recipe: Recipe
    
    var body: some View {
        VStack {
            Text(recipe.title)
                .font(.title)
            Divider()
            Text("Ingredients:")
                .font(.headline)
            Text(recipe.ingredients.joined(separator: ", "))
                .padding(.bottom)
            Text("Instructions:")
                .font(.headline)
            Text(recipe.instructions)
            Spacer()
        }
        .padding()
        .navigationTitle(recipe.title)
    }
}

// Struttura generica per la visualizzazione di una ricetta
struct RecipeView: View {
    var recipe: Recipe
    
    var body: some View {
        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
            RecipeCard(imageName: recipe.imageName, title: recipe.title, description: recipe.description, isSaved: recipe.isSaved)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// Define Recipe structure
struct Recipe: Identifiable {
    let id = UUID()
    let title: String
    let ingredients: [String]
    let instructions: String
    let imageName: String
    let description: String
    var isSaved: Bool = false
}

struct ContentView: View {
    //Variabili

    var body: some View {
        NavigationView {
            TabView {
                HomeView(breakfastRecipe: breakfastRecipes)
                    .tabItem {
                        Image(systemName: "fork.knife")
                    }
                SavedRecipesView()
                    .tabItem {
                        Image(systemName: "heart")
                    }
            }
        }
    }
}

// Sezione ricette salvate
struct SavedRecipesView: View {
    var body: some View {
        Text("Saved Recipes")
            .navigationTitle("Saved")
        // for each saved recipe
        /*
         NavigationLink(destination: RecipeDetailView(recipe: ricetta1)) {
             RecipeCard(imageName: "risotto", title: "Risotto di Mare", description: "Frutti di mare del risotto alla pilota, un piatto tradizionale del mantovano che ha una preparazione curiosa", isSaved: false)
         }
         .buttonStyle(PlainButtonStyle())
         */
    }
}

// Sezione home
struct HomeView: View {
    
    let breakfastRecipe : [Recipe]
    
    let ricetta1 = Recipe(title: "Risotto di Mare", ingredients: ["Ingrediente 1", "Ingrediente 2"], instructions: "Istruzioni 1", imageName: "risotto", description: "Description for Risotto di Mare")
        
        let ricetta2 = Recipe(title: "Ricetta 2", ingredients: ["Ingrediente 3", "Ingrediente 4"], instructions: "Istruzioni 2", imageName: "polpette", description: "Description for Ricetta 2")
        
    var body: some View {

        NavigationView {
            VStack {
                Text("Cosa vuoi mangiare oggi?")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title) // Puoi modificare lo stile del font come preferisci
                    .fontWeight(.light) // Imposta il peso del font
                    .padding(10)
                
                SearchBar() // Aggiungi la barra di ricerca
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack() { // Riduci lo spacing tra i bottoni
                        // Bottone Colazione
                        Button(action: {
                            // Azione da eseguire quando viene premuto il pulsante della colazione
                        }) {
                            NavigationLink(destination: BreakfastRecipesView()) {
                            ZStack{
                                Text("Colazione")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .frame(width: 150, height: 90) // Imposta larghezza e altezza del Text
                                    .foregroundColor(.white)
                                    .background(Color.black)
                                    .cornerRadius(30) // Maggiore valore per arrotondare gli angoli
                                    .font(.largeTitle) // Imposta la dimensione del testo
                                                    
                                    Image("colazione")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 150, height: 90)
                                        .cornerRadius(30)
                                        .clipped()
                                        .opacity(0.4)
                                }
                        }
                    }
                                        
                    // Bottone Pranzo
                    Button(action: {
                        // Azione da eseguire quando viene premuto il pulsante del pranzo
                    }) {
                    NavigationLink(destination: LunchRecipesView()) {
                        ZStack{
                            Text("Pranzo")
                                .font(.title)
                                .fontWeight(.bold)
                                .frame(width: 150, height: 90) // Imposta larghezza e altezza del Text
                                .foregroundColor(.white)
                                .background(Color.black)
                                .cornerRadius(30) // Maggiore valore per arrotondare gli angoli
                                .font(.largeTitle) // Imposta la dimensione del testo
                                                    
                            Image("pranzo")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 150, height: 90)
                                .cornerRadius(30)
                                .clipped()
                                .opacity(0.4)
                            }
                        }
                    }
                                        
                    // Bottone Cena
                    Button(action: {
                        // Azione da eseguire quando viene premuto il pulsante della cena
                    }) {
                    NavigationLink(destination: DinnerRecipesView()) {
                        ZStack{
                            Text("Cena")
                                .font(.title)
                                .fontWeight(.bold)
                                .frame(width: 150, height: 90) // Imposta larghezza e altezza del Text
                                .foregroundColor(.white)
                                .background(Color.black)
                                .cornerRadius(30) // Maggiore valore per arrotondare gli angoli
                                .font(.largeTitle) // Imposta la dimensione del testo
                                                
                            Image("cena")
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
                .padding()
            }
                
            Text("RICETTE DEL GIORNO")
                .font(.title) // Puoi modificare lo stile del font come preferisci
                .fontWeight(.light) // Imposta il peso del font
                .padding(.top, 10)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    HStack {
                        
                            VStack {
                                // Rettangolo cliccabile per la ricetta
                                NavigationLink(destination: RecipeDetailView(recipe: ricetta1)) {
                                    RecipeCard(imageName: "risotto", title: "Risotto di Mare", description: "Frutti di mare del risotto alla pilota, un piatto tradizionale del mantovano che ha una preparazione curiosa", isSaved: false)
                                }
                                .buttonStyle(PlainButtonStyle())
                               
                                NavigationLink(destination: RecipeDetailView(recipe: ricetta2)) {
                                        RecipeCard(imageName: "polpette", title: "Polpette al Sugo", description: "I modi per preparare le polpette di carne sono davvero tanti... ogni nonna custodisce la sua ricetta segretamente, ma oggi vogliamo mostrarvi come le prepariamo noi", isSaved: false)
                                    }
                                }
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .background(Color.white) // Sfondo bianco per il resto della schermata
//            .navigationBarHidden(false) // Nasconde la barra di navigazione
            }
        }

// Sezione ricerca: COLAZIONE
struct BreakfastRecipesView: View {
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(breakfastRecipes) { recipe in
                    RecipeView(recipe: recipe)
                }
            }
            .padding()
        }
        .navigationTitle("Colazione")
    }
}

// Sezione ricerca: PRANZO
struct LunchRecipesView: View {
    var body: some View {
        List {
            
            // Aggiungi altre ricette per il pranzo
        }
        .navigationTitle("Pranzo")
    }
}

// Sezione ricerca: CENA
struct DinnerRecipesView: View {
    var body: some View {
        List {
            
            // Aggiungi altre ricette per la cena
        }
        .navigationTitle("Cena")
    }
}

// Rettangolo per la visualizzazione della ricetta
struct RecipeCard: View {
    var imageName: String
    var title: String
    var description: String
    @State var isSaved: Bool // Utilizziamo @State per tenere traccia dello stato di salvataggio
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 150) // Altezza ridotta dell'immagine
                    .cornerRadius(8)
                    .clipped()
                
                Button(action: {
                    // Cambia lo stato di salvataggio quando viene premuto il pulsante
//                    savedRecipes.append()
                }) {
                    Image(systemName: isSaved ? "heart.fill" : "heart")
                        .foregroundColor(isSaved ? .red : .white)
                        .padding(8)
                        .background(Color.black.opacity(0.6))
                        .clipShape(Circle())
                        .padding(8)
                }
            }
            
            Text(title)
                .font(.headline) // Ridimensiona il titolo
                .foregroundColor(.primary)
            
            Text(description)
                .foregroundColor(.secondary)
                .font(.subheadline) // Ridimensiona la descrizione
                .lineLimit(2) // Limita il numero di righe per la descrizione
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
        .padding(.horizontal)
    }
}

// Barra di ricerca
struct SearchBar: View {
    @State private var searchText = ""

    var body: some View {
        ZStack(alignment: .leading) {
            TextField("Cerca ricetta", text: $searchText)
                .padding(7)
                .padding(.leading, 30) // Aggiunge spazio a sinistra per il testo, evitando la sovrapposizione con l'icona
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 15)

            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.leading, 15) // Allinea l'icona con il bordo sinistro della TextField
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
