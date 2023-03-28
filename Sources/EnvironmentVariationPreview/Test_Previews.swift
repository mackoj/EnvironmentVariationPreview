import Foundation
import SwiftUI


struct Previews_Test_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      Label("Variation Preview", systemImage: "basketball")
        .fontWeight(.bold)
        .foregroundColor(Color("fg", bundle: .module))
        .padding()
        .background(Color("bg", bundle: .module))
        .cornerRadius(4)
        .environmentVariations([ .colorScheme(.light), .colorScheme(.dark), .layoutDirection(.rightToLeft), .dynamicTypeSize(.xSmall), .dynamicTypeSize(.large), .dynamicTypeSize(.xxxLarge)])
        .previewLayout(.sizeThatFits)
    }
  }
}
