#if targetEnvironment(simulator)
import Foundation

/// A wrapper for `EnvironmentValueItem` that adds conformance to `Hashable` and `Identifiable` protocols.
///
/// This type allows you to use `EnvironmentValueItem` instances in places where SwiftUI requires
/// hashable and identifiable elements, such as lists, sets, or dictionary keys.
///
/// The `@dynamicMemberLookup` attribute allows you to access properties and methods of the
/// wrapped `EnvironmentValueItem` instance directly through the `HashableEnvironmentValueItem`.
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
@dynamicMemberLookup public struct HashableEnvironmentValueItem {
  public let id: UUID
  let item: EnvironmentValueItem
  
  /// Initialize a new `HashableEnvironmentValueItem` with the given `EnvironmentValueItem`.
  ///
  /// - Parameter item: The `EnvironmentValueItem` instance to be wrapped.
  public init(item: EnvironmentValueItem) {
    self.id = UUID()
    self.item = item
  }
  
  /// Subscript for accessing properties and methods of the wrapped `EnvironmentValueItem` directly.
  ///
  /// - Parameter keyPath: The key path to the property or method to access.
  public subscript<T>(dynamicMember keyPath: KeyPath<EnvironmentValueItem, T>) -> T {
      item[keyPath: keyPath]
  }
}

/// Add `Hashable` conformance to `HashableEnvironmentValueItem`.
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension HashableEnvironmentValueItem: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  public static func == (lhs: HashableEnvironmentValueItem, rhs: HashableEnvironmentValueItem) -> Bool {
    lhs.id == rhs.id
  }
}

/// Add `Identifiable` conformance to `HashableEnvironmentValueItem`.
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension HashableEnvironmentValueItem: Identifiable { }
#endif
