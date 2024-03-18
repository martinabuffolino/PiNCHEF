import Foundation
import SwiftUI

// Recipe full page
struct RecipeDetailView: View {
    @StateObject private var watchConnector: WatchConnector = WatchConnector()
    
    @State var isInstructionsSheetPresented = false
    @State var selectedRecipe: Recipe? = nil
    
    @State private var selectedIngredients: [String: Bool] = [:]
    
    var recipe: Recipe
    var isHeartRed: Bool
    var toggleHeart: () -> Void
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading){
                ZStack{
                    Image(recipe.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .edgesIgnoringSafeArea(.horizontal)
                        .aspectRatio(4/3, contentMode: .fill)
                        .frame(height: 200)
                        .clipped()
                    
                    Color.black.opacity(0.5)
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .edgesIgnoringSafeArea(.horizontal)
                        .aspectRatio(4/3, contentMode: .fill)
                        .frame(height: 200)
                    
                    Text(recipe.title)
                        .fontWeight(.black)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 15)
                        .padding(.vertical)
                        .foregroundColor(.white)
                        .font(.system(size: 40))
                        .lineLimit(nil)
                    
                    VStack{
                        HStack{
                            Spacer()
                            Button(action:  {
                                toggleHeart()
                                if(isHeartRed){
                                    watchConnector.sendMessage(key: "rmvPref", value: recipe.title)}
                                else if (!isHeartRed){
                                    watchConnector.sendMessage(key: "addPref", value: recipe.title)}
                            }){
                                Image(systemName: isHeartRed ? "heart.fill" : "heart")
                                    .foregroundColor(isHeartRed ? .red : .white)
                                    .padding(8)
                                    .background(Color.black.opacity(0.6))
                                    .clipShape(Circle())
                                    .padding(8)
                            }
                        }
                        Spacer()
                    }
                }
                
                VStack{
                    HStack {
                        VStack(spacing: 10) {
                            HStack(spacing: 10) {
                                RecipePropertyView(imageName: "frying.pan", value: "\(recipe.difficulty)", label: "Difficulty")
                                RecipePropertyView(imageName: "person", value: "\(recipe.servingSize)", label: "Serving")
                            }
                            HStack(spacing: 10) {
                                RecipePropertyView(imageName: "timer", value: "\(recipe.time)m", label: "Time")
                                RecipePropertyView(imageName: "dollarsign.circle", value: "\(recipe.cost)", label: "Cost")
                            }
                        }
                    }
                }.padding()
                
                Text("Ingredients")
                    .font(.system(size: 35))
                    .fontWeight(.bold)
                    .foregroundColor(Color.yellow)
                    .padding(.vertical, 5)
                    .padding(.horizontal,15)
                
                HStack{
                    ZStack{
                        VStack{
                            Divider()
                            ForEach(recipe.ingredients, id: \.name) { ingredient in
                                Button(action: {
                                    selectedIngredients[ingredient.name, default: false].toggle()
                                }) {
                                    HStack {
                                        Circle()
                                            .frame(width: 15, height: 15)
                                            .foregroundColor(selectedIngredients[ingredient.name] ?? false ? .yellow : .white)
                                            .shadow(radius: 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(Color.black, lineWidth: 0.3)
                                            )
                                        
                                        Text("\(ingredient.name)")
                                            .fontWeight(.semibold)
                                            .font(.system(size: 22))
                                        Spacer()
                                        
                                        Text("\(ingredient.quantity)")
                                            .fontWeight(.black)
                                            .font(.system(size: 18))
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                                Divider()
                            }
                        }
                        .font(.headline)
                        .fontWeight(.medium)
                        .padding(15)
                        .frame(maxWidth: .infinity)
                        .background(Color.clear)
                        .overlay(
                            Rectangle()
                                .stroke(Color.black, lineWidth: 0.3)
                        )
                    }
                    .background(Color(red: 249/255, green: 246/255, blue: 227/255))
                    .padding()
                }
                
                Spacer().frame(height: 20)
                HStack(spacing: 20){
                    Spacer()
                    Button(action: {
                        self.isInstructionsSheetPresented.toggle()
                    }) {
                        Text("Instructions")
                            .font(.system(size: 14))
                            .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                            .foregroundColor(.yellow)
                            .frame(maxWidth: .infinity)
                            .background(.clear)
                            .clipShape(Capsule())
                            .overlay(
                                Capsule()
                                    .stroke(Color.yellow, lineWidth: 4)
                            )
                            .fontWeight(.black)
                    }
                    .popover(isPresented: $isInstructionsSheetPresented) {
                        GeometryReader { geometry in
                            VStack {
                                Spacer()
                                InstructionsPopover(recipe: recipe, isInstructionsPopoverPresented: $isInstructionsSheetPresented)
                            }
                        }
                    }
                    
                    Button(action: {
                        watchConnector.sendMessage(key: "testo", value: recipe.title)
                    }) {
                        Text("Cook")
                            .font(.system(size: 17))
                            .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .background(.yellow)
                            .clipShape(Capsule())
                            .fontWeight(.black)
                    }
                    Spacer()
                }
                Spacer()
            }
            Spacer().frame(height: 25)
        }
    }
}
