// The library compiles only for the simulator, so these tests run there:
// `xcodebuild test -scheme EnvironmentVariationPreview -destination 'platform=iOS Simulator,name=…'`.
#if targetEnvironment(simulator)
import SwiftUI
import XCTest
@testable import EnvironmentVariationPreview

final class EnvironmentVariationPreviewTests: XCTestCase {
  func testArrayLiteralKeepsOrder() {
    let list: EnvironmentValueItemList = [.colorScheme(.light), .colorScheme(.dark), .layoutDirection(.rightToLeft)]
    XCTAssertEqual(list.count, 3)
    XCTAssertEqual(list.map(\.description), [
      "colorScheme: light",
      "colorScheme: dark",
      "layoutDirection: rightToLeft",
    ])
  }

  func testEachItemHasItsOwnIdentity() {
    let list: EnvironmentValueItemList = [.colorScheme(.light), .colorScheme(.light)]
    XCTAssertNotEqual(list[0], list[1])
    XCTAssertEqual(Set(list.map(\.id)).count, 2)
    XCTAssertEqual(list[0], list[0])
  }

  func testColorSchemeIsReadBackOnlyFromColorSchemeCases() {
    let list: EnvironmentValueItemList = [.colorScheme(.dark), .isEnabled(false)]
    XCTAssertEqual(list[0].colorScheme, .dark)
    XCTAssertNil(list[1].colorScheme)
  }

  func testDescriptionsNameTheirCase() {
    XCTAssertEqual(EnvironmentValueItem.lineLimit(nil).description, "lineLimit: nil")
    XCTAssertEqual(EnvironmentValueItem.lineLimit(2).description, "lineLimit: Optional(2)")
    XCTAssertEqual(EnvironmentValueItem.legibilityWeight(.bold).description, "legibilityWeight: bold")
    XCTAssertEqual(EnvironmentValueItem.legibilityWeight(nil).description, "legibilityWeight: nil")
    XCTAssertEqual(EnvironmentValueItem.isEnabled(true).description, "isEnabled: true")
  }

  func testDefaultVariationsBuildAView() {
    let view = Text("Hello").environmentVariations()
    XCTAssertNotNil(view)
  }

  /// The captions drawn on site/index.html.
  @available(iOS 15.0, tvOS 15.0, watchOS 8.0, *) // DynamicTypeSize
  func testCaptionsShownOnTheSite() {
    let list: EnvironmentValueItemList = [
      .colorScheme(.light), .colorScheme(.dark), .layoutDirection(.rightToLeft),
      .dynamicTypeSize(DynamicTypeSize.xSmall), .dynamicTypeSize(DynamicTypeSize.xxxLarge),
    ]
    XCTAssertEqual(list.map(\.description), [
      "colorScheme: light",
      "colorScheme: dark",
      "layoutDirection: rightToLeft",
      "dynamicTypeSize: xSmall",
      "dynamicTypeSize: xxxLarge",
    ])
    let locale: EnvironmentValueItemList = [.locale(Locale(identifier: "fr_FR"))]
    XCTAssertTrue(locale[0].description.hasPrefix("locale: fr_FR"), locale[0].description)
  }
}
#endif
