#if targetEnvironment(simulator)
import Foundation
import SwiftUI

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
