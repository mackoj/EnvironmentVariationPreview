import Foundation
import SwiftUI

@available(iOS 16.4, macOS 13.3, tvOS 14.0, watchOS 7.0, *)
extension View {
  func applyEnvironmentValue(_ value: HashableEnvironmentValueItem) -> some View {
    self.modifier(EnvironmentValueItemModifier(environmentValue: value))
  }
}

@available(iOS 16.4, macOS 13.3, tvOS 14.0, watchOS 7.0, *)
struct EnvironmentValueItemModifier: ViewModifier {
  let environmentValue: HashableEnvironmentValueItem
  
  func body(content: Content) -> some View {
    environmentValue.item.apply(to: content)
  }
}
