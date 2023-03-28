import Foundation

@available(iOS 16.4, macOS 13.3, tvOS 14.0, watchOS 7.0, *)
public struct EnvironmentValueItemList {
  let items: [HashableEnvironmentValueItem]
}

@available(iOS 16.4, macOS 13.3, tvOS 14.0, watchOS 7.0, *)
extension EnvironmentValueItemList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: EnvironmentValueItem...) {
    self.items = elements.map(HashableEnvironmentValueItem.init(item:))
  }
}

@available(iOS 16.4, macOS 13.3, tvOS 14.0, watchOS 7.0, *)
extension EnvironmentValueItemList: RandomAccessCollection {
  public typealias Element = HashableEnvironmentValueItem
  public typealias Index = Array<HashableEnvironmentValueItem>.Index
  
  public var startIndex: Index {
    return items.startIndex
  }
  
  public var endIndex: Index {
    return items.endIndex
  }
  
  public func index(after i: Index) -> Index {
    return items.index(after: i)
  }
  
  public func index(before i: Index) -> Index {
    return items.index(before: i)
  }
  
  public subscript(position: Index) -> Element {
    return items[position]
  }
}
