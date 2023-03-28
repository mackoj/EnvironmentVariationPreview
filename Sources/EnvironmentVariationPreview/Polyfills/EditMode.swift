import Foundation
import SwiftUI

#if os(macOS)
enum EditMode {
  case active
  case inactive
  case transient
}

struct EditModeEnvironmentKey: EnvironmentKey {
    static let defaultValue: Binding<EditMode>? = nil
}

extension EnvironmentValues {
    var editMode: Binding<EditMode>? {
        get { return self[EditModeEnvironmentKey.self] }
        set { self[EditModeEnvironmentKey.self] = newValue }
    }
}
#endif
