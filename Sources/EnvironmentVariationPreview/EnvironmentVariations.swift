#if targetEnvironment(simulator)
import Foundation
import SwiftUI

extension View {
  /// `environmentVariations` is a `ViewModifier` that allows previewing a SwiftUI `View` with differents environment values.
  ///
  /// In this example, MyView is previewed using various environment values, including light/dark mode, right-to-left/left-to-right layout direction, and different dynamic type sizes.
  ///
  /// Example usage:
  /// ```swift
  /// struct MyView: View {
  ///   var body: some View {
  ///     Text("Hello, World!")
  ///   }
  /// }
  ///
  /// struct MyView_Previews: PreviewProvider {
  ///   static var previews: some View {
  ///     MyView().environmentVariations([ .colorScheme(.light), .colorScheme(.dark), .layoutDirection(.rightToLeft), .dynamicTypeSize(.xSmall), .dynamicTypeSize(.large), .dynamicTypeSize(.xxxLarge)]) // Use default environment values
  ///   }
  /// }
  /// ```
  public func environmentVariations(
    _ variarions: EnvironmentValueItemList = [.colorScheme(.light), .colorScheme(.dark)]
  ) -> some View {
    self.modifier(EnvironmentVariationsModifier(variarions: variarions))
  }
}


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
#endif
