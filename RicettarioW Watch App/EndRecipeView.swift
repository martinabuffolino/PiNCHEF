//
//  EndRecipeView.swift
//  RicettarioW Watch App
//
//  Created by Carmine De Micco on 04/03/24.
//

import SwiftUI

struct EndRecipeView: View {
    
    @State private var rotationAngle: Double = 0
    
    var body: some View {
        ZStack {
            Image("rays")
                .scaleEffect(CGSize(width: 0.5, height: 0.4))
                .rotationEffect(Angle(degrees: rotationAngle))
                .onAppear {
                    withAnimation(Animation.linear(duration: 26).repeatForever(autoreverses: false)) {rotationAngle = 360}
                }
            
            VStack {
                
                Text("Preparation Completed!")
                    .font(.system(size: 14))
                    .bold()

                Text("🧑🏼‍🍳")
                    .font(.system(size: 80))
                
                Text("Tap fingers to turn to menu")
                    .opacity(0.8)
                    .font(.system(size: 11))
                    .padding(.bottom,0)
                
            }
            
        }
        .padding(.top,0)
        .padding(.bottom,0)
    }
}

#Preview {
    EndRecipeView()
}
