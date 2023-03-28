import Foundation
import SwiftUI


struct Previews_Test_Previews: PreviewProvider {
  static var previews: some View {
    Label("Variation Preview", systemImage: "basketball")
      .fontWeight(.bold)
      .foregroundColor(Color("fakeWhite", bundle: .module))
      .padding()
      .background(.yellow)
      .cornerRadius(4)
      .environmentVariations([ .colorScheme(.light), .colorScheme(.dark), .layoutDirection(.rightToLeft), .dynamicTypeSize(.xSmall), .dynamicTypeSize(.large), .dynamicTypeSize(.xxxLarge)])
      .previewLayout(.sizeThatFits)
  }
}

