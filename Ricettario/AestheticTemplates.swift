import Foundation
import SwiftUI

struct CategoryButton: View {
    let title: String
    let imageName: String
    
    var body: some View {
        ZStack{
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .frame(width: 150, height: 90)
                .foregroundColor(.white)
                .background(Color.black)
                .cornerRadius(30)
                .font(.largeTitle)
            
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 90)
                .cornerRadius(30)
                .clipped()
                .opacity(0.4)
        }
    }
}
