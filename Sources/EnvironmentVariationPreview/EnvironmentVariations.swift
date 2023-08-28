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
  /// - Parameters:
  ///   - variarions: A list of environment values to apply to the view. The default value is `[.colorScheme(.light), .colorScheme(.dark)]`.
  ///   - alignment: The guide for aligning the subviews in this stack. This
  ///     guide has the same vertical screen coordinate for every subview.
  ///   - spacing: The distance between adjacent subviews, or `nil` if you
  ///     want the stack to choose a default distance for each pair of
  ///     subviews.
  /// - Returns: A modified view that displays previews of the original view with each of the specified environment values.
  @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
  public func environmentVariations(
    _ variarions: EnvironmentValueItemList = [.colorScheme(.light), .colorScheme(.dark)],
    _ alignment: HorizontalAlignment = .center,
    _ spacing: CGFloat? = nil
  ) -> some View {
    self.modifier(EnvironmentVariationsModifier(variarions: variarions, alignment: alignment, spacing: spacing))
  }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
struct EnvironmentVariationsModifier: ViewModifier {
  /// The list of environment values to apply to the content view.
  let variarions: EnvironmentValueItemList
  
  /// The guide for aligning the subviews in this stack. This guide has the same vertical screen coordinate for every subview.
  let alignment: HorizontalAlignment
  
  /// The distance between adjacent subviews, or `nil` if you want the stack to choose a default distance for each pair of subviews.
  let spacing: CGFloat?

  /// Returns a modified view that displays previews of the content view with each of the specified environment values.
  ///
  /// - Parameter content: The content view to which the environment values will be applied.
  /// - Returns: A modified view that displays previews of the content view with each of the specified environment values.
  func body(content: Content) -> some View {
    Group {
      ForEach(variarions, id: \.self) { environmentValue in
        VStack(alignment: alignment, spacing: spacing) {
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
        .background(environmentValue.colorScheme == .dark ? Color.black : Color.white)
        .fixedSize()
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .contentShape(RoundedRectangle(cornerRadius: 4))
        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 1), alignment: .center)
      }
    }
  }
}
#endif
