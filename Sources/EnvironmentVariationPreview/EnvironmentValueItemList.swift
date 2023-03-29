#if targetEnvironment(simulator)
import Foundation

/// A public structure representing a list of environment values that can be used to customize SwiftUI views.
///
public struct EnvironmentValueItemList {
    /// An array of `HashableEnvironmentValueItem` items that make up the list.
    let items: [HashableEnvironmentValueItem]
}

extension EnvironmentValueItemList: ExpressibleByArrayLiteral {
    /// Initializes an instance of `EnvironmentValueItemList` using an array literal.
    ///
    /// - Parameter elements: An array literal of `EnvironmentValueItem` elements.
    public init(arrayLiteral elements: EnvironmentValueItem...) {
        self.items = elements.map(HashableEnvironmentValueItem.init(item:))
    }
}

extension EnvironmentValueItemList: RandomAccessCollection {
    /// The type of elements contained in the collection.
    public typealias Element = HashableEnvironmentValueItem
    /// The type of the collection's index.
    public typealias Index = Array<HashableEnvironmentValueItem>.Index

    /// The start index of the collection.
    public var startIndex: Index {
        return items.startIndex
    }

    /// The end index of the collection.
    public var endIndex: Index {
        return items.endIndex
    }

    /// Returns the index immediately after the given index.
    ///
    /// - Parameter i: A valid index of the collection.
    /// - Returns: The index immediately after the given index.
    public func index(after i: Index) -> Index {
        return items.index(after: i)
    }

    /// Returns the index immediately before the given index.
    ///
    /// - Parameter i: A valid index of the collection.
    /// - Returns: The index immediately before the given index.
    public func index(before i: Index) -> Index {
        return items.index(before: i)
    }

    /// Accesses the element at the specified position.
    ///
    /// - Parameter position: The position of the element to access.
    /// - Returns: The element at the specified position.
    public subscript(position: Index) -> Element {
        return items[position]
    }
}
#endif
