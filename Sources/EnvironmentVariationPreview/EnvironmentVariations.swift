#if targetEnvironment(simulator)
import Foundation
import SwiftUI

/// A SwiftUI `View` extension that provides an `environmentVariations` function. This function accepts a list of environment values and returns a modified view that displays previews of the original view with each of the specified environment values.
///
/// - Note: This code is designed to run in the simulator environment only.
///
extension View {
  /// Applies the specified environment values to the view and returns a modified view displaying each variation.
  ///
  /// By default, `environmentVariations` will use a light and dark color scheme.
  ///
  /// - Parameter variarions: A list of environment values to apply to the view. The default value is `[.colorScheme(.light), .colorScheme(.dark)]`.
  /// - Returns: A modified view that displays previews of the original view with each of the specified environment values.
  public func environmentVariations(
    _ variarions: EnvironmentValueItemList = [.colorScheme(.light), .colorScheme(.dark)]
  ) -> some View {
    self.modifier(EnvironmentVariationsModifier(variarions: variarions))
  }
}


struct EnvironmentVariationsModifier: ViewModifier {
  /// The list of environment values to apply to the content view.
  let variarions: EnvironmentValueItemList
  
  /// Returns a modified view that displays previews of the content view with each of the specified environment values.
  ///
  /// - Parameter content: The content view to which the environment values will be applied.
  /// - Returns: A modified view that displays previews of the content view with each of the specified environment values.
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
