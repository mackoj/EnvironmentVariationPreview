#if targetEnvironment(simulator)
import Foundation
import SwiftUI

extension View {
  func applyEnvironmentValue(_ value: HashableEnvironmentValueItem) -> some View {
    self.modifier(EnvironmentValueItemModifier(environmentValue: value))
  }
}

struct EnvironmentValueItemModifier: ViewModifier {
  let environmentValue: HashableEnvironmentValueItem
  
  func body(content: Content) -> some View {
    environmentValue.item.apply(to: content)
  }
}
#endif
