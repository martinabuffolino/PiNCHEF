import Foundation
import SwiftUI

// Recipes Steps
struct InstructionsPopover: View {
    var recipe: Recipe
    
    @Binding var isInstructionsPopoverPresented: Bool
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack{
                Text("Instructions")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.vertical, 10)
                Spacer()
                Button("✖") {
                    dismiss()
                }
            }
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(recipe.instructions.indices, id: \.self) { index in
                        let stepNumber = index + 1
                        let instruction = recipe.instructions[index]
                        VStack(alignment: .leading) {
                            HStack(alignment: .top) {
                                Text("\(stepNumber)")
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .foregroundColor(.yellow)
                                Text(instruction.text)
                                    .font(.system(size: 16))
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                                    .shadow(color: .gray, radius: 2)
                            )
                        }
                        .padding([.bottom, .top], 5)
                    }
                }
                .padding()
            }
        }
        .padding()
        .background(.yellow)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}
