import Foundation

@available(iOS 16.4, macOS 13.3, tvOS 14.0, watchOS 7.0, *)
struct EnvironmentValueItemList {
  let items: [HashableEnvironmentValueItem]
}

@available(iOS 16.4, macOS 13.3, tvOS 14.0, watchOS 7.0, *)
extension EnvironmentValueItemList: ExpressibleByArrayLiteral {
  init(arrayLiteral elements: EnvironmentValueItem...) {
    self.items = elements.map(HashableEnvironmentValueItem.init(item:))
  }
}

@available(iOS 16.4, macOS 13.3, tvOS 14.0, watchOS 7.0, *)
extension EnvironmentValueItemList: RandomAccessCollection {
  typealias Element = HashableEnvironmentValueItem
  typealias Index = Array<HashableEnvironmentValueItem>.Index
  
  var startIndex: Index {
    return items.startIndex
  }
  
  var endIndex: Index {
    return items.endIndex
  }
  
  func index(after i: Index) -> Index {
    return items.index(after: i)
  }
  
  func index(before i: Index) -> Index {
    return items.index(before: i)
  }
  
  subscript(position: Index) -> Element {
    return items[position]
  }
}
