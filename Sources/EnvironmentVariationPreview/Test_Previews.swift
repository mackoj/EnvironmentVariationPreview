import Foundation
import SwiftUI

@available(iOS 16.4, macOS 13.3, tvOS 14.0, watchOS 7.0, *)
struct Previews_Test_Previews: PreviewProvider {
  static var previews: some View {
    Label("Variation Preview", systemImage: "basketball")
      .fontWeight(.bold)
      .foregroundColor(Color("fakeWhite", bundle: .module))
      .padding()
      .background(.yellow)
      .cornerRadius(4)
      .environmentVariations([ .colorScheme(.light), .colorScheme(.dark), .layoutDirection(.rightToLeft), .dynamicTypeSize(.xSmall), .dynamicTypeSize(.large), .dynamicTypeSize(.xxxLarge) ])
      .previewLayout(.sizeThatFits)
  }
}

