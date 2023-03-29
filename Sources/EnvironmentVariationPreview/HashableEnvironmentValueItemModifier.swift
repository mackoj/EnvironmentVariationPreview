#if targetEnvironment(simulator)
import Foundation
import SwiftUI

/// An extension to the `View` protocol that adds the ability to apply a `HashableEnvironmentValueItem` as a modifier.
extension View {
  /// Apply the specified `HashableEnvironmentValueItem` to the view.
  ///
  /// This method allows you to easily apply an environment value stored in a `HashableEnvironmentValueItem`
  /// instance to the current view.
  ///
  /// - Parameter value: The `HashableEnvironmentValueItem` to apply to the view.
  /// - Returns: A new view with the environment value applied.
  func applyEnvironmentValue(_ value: HashableEnvironmentValueItem) -> some View {
    self.modifier(EnvironmentValueItemModifier(environmentValue: value))
  }
}

/// A `ViewModifier` implementation for applying a `HashableEnvironmentValueItem` to a view.
struct EnvironmentValueItemModifier: ViewModifier {
  let environmentValue: HashableEnvironmentValueItem
  
  /// The body of the view modifier.
  ///
  /// Applies the `HashableEnvironmentValueItem` to the given content.
  ///
  /// - Parameter content: The content to which the environment value should be applied.
  /// - Returns: A new view with the environment value applied.
  func body(content: Content) -> some View {
    environmentValue.item.apply(to: content)
  }
}
#endif
