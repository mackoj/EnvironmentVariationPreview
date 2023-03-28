#if targetEnvironment(simulator)
import Foundation

public struct EnvironmentValueItemList {
  let items: [HashableEnvironmentValueItem]
}

extension EnvironmentValueItemList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: EnvironmentValueItem...) {
    self.items = elements.map(HashableEnvironmentValueItem.init(item:))
  }
}

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
#endif
