//
//  NoRecipeView.swift
//  RicettarioW Watch App
//
//  Created by Carmine De Micco on 15/03/24.
//

import SwiftUI

struct NoRecipeView: View {
    var body: some View {
        VStack{
            Spacer()
            
            Image(systemName: "heart.slash.fill")
            Text("No recipes\nsaved.")
                .multilineTextAlignment(.center)
                .font(.headline)
            
            Spacer()
                
            Text("Save or start cooking recipes from your iPhone!")
                .multilineTextAlignment(.center)
                .font(.footnote)
                .opacity(0.6)
            
            Spacer()
        }

    }
}

#Preview {
    NoRecipeView()
}
