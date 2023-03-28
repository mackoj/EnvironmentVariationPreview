import Foundation

/// This type add support for `Hashable` and `Identifiable` to `EnvironmentValueItem`
@available(iOS 16.4, macOS 13.3, tvOS 14.0, watchOS 7.0, *)
@dynamicMemberLookup struct HashableEnvironmentValueItem {
  let id: UUID
  let item: EnvironmentValueItem
  
  init(item: EnvironmentValueItem) {
    self.id = UUID()
    self.item = item
  }
  
  subscript<T>(dynamicMember keyPath: KeyPath<EnvironmentValueItem, T>) -> T {
      item[keyPath: keyPath]
  }
}

@available(iOS 16.4, macOS 13.3, tvOS 14.0, watchOS 7.0, *)
extension HashableEnvironmentValueItem: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  static func == (lhs: HashableEnvironmentValueItem, rhs: HashableEnvironmentValueItem) -> Bool {
    lhs.id == rhs.id
  }
}

@available(iOS 16.4, macOS 13.3, tvOS 14.0, watchOS 7.0, *)
extension HashableEnvironmentValueItem: Identifiable { }
