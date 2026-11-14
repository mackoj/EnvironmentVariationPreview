import LLMCheck
import Testing

/// Each detector on snippets: it finds what its rule forbids and nothing its rule allows.
@Suite struct DetectorTests {
    func scope(_ source: String, at path: String = "Sources/EnvironmentVariationPreview/File.swift") -> Scope {
        Scope(files: [SourceFile(path: path, source: source)])
    }

    @Test func importsOverBudgetAreFound() {
        let found = Detect.importsOverBudget(
            in: scope(
                """
                import Foundation
                import SwiftUI
                import CoreData
                import UIKit
                @testable import Combine
                """))
        #expect(found.map(\.location.line) == [4, 5])
    }

    @Test func availabilityOffTheFloorIsFound() {
        let found = Detect.availabilityOffTheFloor(
            in: scope(
                """
                @available(iOS 13.0, *)
                extension A {}
                @available(iOS 14.0, macOS 11.0, *)
                struct B {}
                @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
                struct C {}
                @available(*, deprecated, renamed: "d")
                func e() {}
                """),
            floor: "iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *")
        #expect(found.map(\.location.line) == [1, 3])
    }

    @Test func publicDeclarationsWithoutAvailabilityAreFound() {
        let found = Detect.publicDeclarationsWithoutAvailability(
            in: scope(
                """
                public struct A {
                  public init() {}
                }
                @available(iOS 14.0, *)
                public enum B {}
                extension View {
                  public func c() {}
                  @available(iOS 14.0, *)
                  public func d() {}
                  func e() {}
                }
                @available(iOS 14.0, *)
                extension B {
                  public var f: Int { 0 }
                }
                struct G {}
                """))
        #expect(found.map(\.name) == ["A", "c"])
    }

    @Test func anyViewOutsideApplyIsFound() {
        let found = Detect.anyViewOutsideApply(
            in: scope(
                """
                enum EnvironmentValueItem {
                  func apply<V: View>(to content: V) -> some View { AnyView(content) }
                }
                struct Modifier: ViewModifier {
                  func body(content: Content) -> some View { AnyView(content) }
                }
                """))
        #expect(found.map(\.location.line) == [5])
    }

    @Test func erasedPayloadsWithoutCommentAreFound() {
        let found = Detect.erasedPayloadsWithoutTypeComment(
            in: scope(
                """
                enum EnvironmentValueItem {
                  case dynamicTypeSize(Any) // DynamicTypeSize
                  case symbolRenderingMode(Any?) // SymbolRenderingMode
                  case controlSize(Any)
                  case menuOrder(Any) // TODO
                  case editMode(Binding<Any>?)
                  case colorScheme(ColorScheme)
                }
                """))
        #expect(found.map(\.location.line) == [4, 5])
    }

    @Test func descriptionsNamingAnotherCaseAreFound() {
        let found = Detect.descriptionsNamingAnotherCase(
            in: scope(
                """
                enum EnvironmentValueItem {
                  var description: String {
                    switch self {
                      case .colorScheme(let value): return "colorScheme: \\(value)"
                      case .verticalSizeClass(let value): return "horizontalSizeClass: \\(value)"
                      case .font(let value): return "font \\(value)"
                      case .locale(let value): return String(describing: value)
                    }
                  }
                  var title: String {
                    switch self {
                      case .colorScheme(let value): return "anything"
                    }
                  }
                }
                extension LegibilityWeight {
                  public var description: String {
                    switch self {
                      case .regular: return "regular"
                    }
                  }
                }
                """))
        #expect(found.map(\.location.line) == [5, 6, 7])
    }
}
