import Foundation
import SwiftUI

// Recipes details (4 yellow squares)
struct RecipePropertyView: View {
    var imageName: String
    var value: String
    var label: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 37, height: 37)
                Text(value)
                    .fontWeight(.black)
                    .font(.system(size: 23))
                Spacer()
            }
            Text(label)
                .fontWeight(.heavy)
                .font(.system(size: 20))
        }
        .padding(10)
        .background(Color.yellow)
        .cornerRadius(10)
    }
}
