import Foundation
import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            TextField("Search Recipes", text: $searchText)
                .padding(7)
                .padding(.leading, 30)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
            
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.leading, 15)
        }
    }
}
