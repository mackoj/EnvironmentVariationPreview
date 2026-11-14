#if targetEnvironment(simulator)
import Foundation
import SwiftUI

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension LegibilityWeight: CustomStringConvertible {
  public var description: String {
    switch self {
      case .regular: return "regular"
      case .bold: return "bold"
      @unknown default: return "default"
    }
  }
}
#endif
