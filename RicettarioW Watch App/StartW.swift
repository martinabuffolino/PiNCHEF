//
//  StartWatch.swift
//  RicettarioW Watch App
//
//  Created by Carmine De Micco on 28/02/24.
//

import SwiftUI

struct StartW: View {
    var body: some View {
        VStack{
            Spacer()
            
            Text("Watch and Cook!")
                .font(.title3)
            
            Spacer()
            
            Text("Tap your fingers to go to the next step.")
                .opacity(0.7)
            Text("💥👌🏻")
                .font(.system(size: 35))
            
            Spacer()
        }
        .background(Color.black)
        .padding()
    }
    
}

#Preview {
    StartW()
}
