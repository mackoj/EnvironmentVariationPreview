import Foundation
import SwiftUI

@available(iOS 16.4, macOS 13.3, tvOS 14.0, watchOS 7.0, *)
extension View {
  public func environmentVariations(
    _ variarions: EnvironmentValueItemList = [.colorScheme(.light), .colorScheme(.dark)]
  ) -> some View {
    self.modifier(EnvironmentVariationsModifier(variarions: variarions))
  }
}

@available(iOS 16.4, macOS 13.3, tvOS 14.0, watchOS 7.0, *)
struct EnvironmentVariationsModifier: ViewModifier {
  let variarions: EnvironmentValueItemList
  
  func body(content: Content) -> some View {
    Group {
      ForEach(variarions, id: \.self) { environmentValue in
        VStack(alignment: .center, spacing: 0) {
          content
            .applyEnvironmentValue(environmentValue)
            .padding()
          
          Text(environmentValue.description)
            .foregroundColor(.white)
            .font(.body.weight(.bold))
            .padding(2)
            .frame(maxWidth: .infinity)
            .background(Color.black)
        }
        .fixedSize()
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .contentShape(RoundedRectangle(cornerRadius: 4))
        .overlay {
          RoundedRectangle(cornerRadius: 4)
            .stroke(Color.black, lineWidth: 1)
        }
      }
    }
  }
}
