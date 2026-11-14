// Mirrors the snippets in README.md and site/index.html, so a snippet that stops compiling fails here.
#if targetEnvironment(simulator)
import SwiftUI
import XCTest
import EnvironmentVariationPreview

private struct ProfileCard: View {
  var body: some View {
    HStack {
      Circle().frame(width: 32, height: 32)
      VStack(alignment: .leading) {
        Text("Ada Lovelace").font(.headline)
        Text(Date(timeIntervalSince1970: 1_680_000_000), style: .date)
      }
    }
  }
}

final class ReadmeTests: XCTestCase {
  @available(iOS 15.0, tvOS 15.0, watchOS 8.0, *) // DynamicTypeSize
  func testUsage() {
    let view = ProfileCard()
      .environmentVariations([
        .colorScheme(.light),
        .colorScheme(.dark),
        .layoutDirection(.rightToLeft),
        .dynamicTypeSize(DynamicTypeSize.xSmall),
        .dynamicTypeSize(DynamicTypeSize.large),
        .dynamicTypeSize(DynamicTypeSize.xxxLarge),
        .locale(Locale(identifier: "fr_FR")),
      ])
    XCTAssertNotNil(view)
  }

  @available(iOS 15.0, tvOS 15.0, watchOS 8.0, *) // DynamicTypeSize
  func testDefaultsAlignmentAndSpacing() {
    _ = ProfileCard().environmentVariations()
    _ = ProfileCard().environmentVariations([.horizontalSizeClass(.compact), .horizontalSizeClass(.regular)], .leading, 16)
    _ = ProfileCard().environmentVariations([
      .dynamicTypeSize(DynamicTypeSize.accessibility5),
      .legibilityWeight(.bold),
      .redactionReasons(.placeholder),
    ])
  }
}
#endif
