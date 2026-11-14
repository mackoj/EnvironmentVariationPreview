[![CI](https://github.com/mackoj/EnvironmentVariationPreview/actions/workflows/ci.yml/badge.svg)](https://github.com/mackoj/EnvironmentVariationPreview/actions/workflows/ci.yml)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fmackoj%2FEnvironmentVariationPreview%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/mackoj/EnvironmentVariationPreview)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fmackoj%2FEnvironmentVariationPreview%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/mackoj/EnvironmentVariationPreview)

# EnvironmentVariationPreview

**[Website](https://mackoj.github.io/EnvironmentVariationPreview/)** ·
**[Architecture rules](docs/architecture-rules.md)** ·
**[Performance](docs/performance.md)**

One SwiftUI view modifier, `.environmentVariations([...])`, that renders a view once per environment value, side by
side and captioned: light and dark, right-to-left, the smallest and largest dynamic type, any locale, and 30 more
environment values. It compiles only for the simulator, so it ships nothing in your app.

| video | image |
| --- | --- |
| <video height="640" src="https://user-images.githubusercontent.com/661647/228359780-61f1a897-1b80-41ed-a0b8-26c6b6b5e279.mov"> | <img height="640" alt="Previews of one view in several environments" src="https://user-images.githubusercontent.com/661647/228359752-1c609881-a5c0-4e09-a988-0a18972776a7.png"> |

## Why

An app has to work across dynamic type sizes, appearances, accessibility settings, locales and screen sizes, but a
preview shows one combination at a time. EnvironmentVariationPreview puts them all in one preview, with a caption on
each render naming its environment value, which also makes it a good fit for
[snapshot testing](https://github.com/doordash-oss/swiftui-preview-snapshots) a UI library.

<img width="1512" alt="Xcode with a preview canvas showing many variations" src="https://user-images.githubusercontent.com/661647/228359745-cda5eaaf-837b-4188-a125-a09a41ecdc34.png">

## Installation

Swift Package Manager:

```swift
dependencies: [
  .package(url: "https://github.com/mackoj/EnvironmentVariationPreview.git", from: "1.1.4")
],
targets: [
  .target(name: "MyUI", dependencies: ["EnvironmentVariationPreview"])
]
```

Or in Xcode: File › Add Package Dependencies…, then paste the repository URL.

Requirements: Swift 5.7.1 or later. iOS 14, macOS 11, tvOS 14, watchOS 7 (visionOS builds too), in a simulator or the
preview canvas.

## Usage

```swift
import SwiftUI
import EnvironmentVariationPreview

struct ProfileCard_Previews: PreviewProvider {
  static var previews: some View {
    ProfileCard()
      .environmentVariations([
        .colorScheme(.light),
        .colorScheme(.dark),
        .layoutDirection(.rightToLeft),
        .dynamicTypeSize(DynamicTypeSize.xSmall),
        .dynamicTypeSize(DynamicTypeSize.large),
        .dynamicTypeSize(DynamicTypeSize.xxxLarge),
        .locale(Locale(identifier: "fr_FR")),
      ])
  }
}
```

With no argument, `.environmentVariations()` shows light and dark. The two optional arguments after the list are the
alignment and spacing of the stack that holds each render and its caption:

```swift
ProfileCard().environmentVariations([.horizontalSizeClass(.compact), .horizontalSizeClass(.regular)], .leading, 16)
```

Values whose type is newer than iOS 14 (`DynamicTypeSize`, `Material`, `SymbolVariants`, `MenuOrder`…) take `Any`, so
write the type's name: `.dynamicTypeSize(DynamicTypeSize.xxxLarge)`, not `.dynamicTypeSize(.xxxLarge)`. On a system
older than the type, the value is skipped and the view renders unchanged. If your target still supports iOS 14, a preview
that names `DynamicTypeSize` needs `@available(iOS 15.0, *)` on its `PreviewProvider`.

### Simulator only

Every file is wrapped in `#if targetEnvironment(simulator)`, so on a device or a Mac the module is empty. Use
`.environmentVariations` in previews and simulator tests; wrap any other call in `#if targetEnvironment(simulator)`.

### Supported values

`EnvironmentValueItem` has a case per modifiable `EnvironmentValues` key: `accessibilityEnabled`, `allowsTightening`,
`autocorrectionDisabled`, `backgroundMaterial`, `backgroundStyle`, `calendar`, `colorScheme`, `contentTransition`,
`contentTransitionAddsDrawingGroup`, `defaultMinListHeaderHeight`, `defaultMinListRowHeight`, `disableAutocorrection`,
`displayScale`, `dynamicTypeSize`, `font`, `headerProminence`, `horizontalSizeClass`, `imageScale`, `isEnabled`,
`isLuminanceReduced`, `isScrollEnabled`, `layoutDirection`, `legibilityWeight`, `lineLimit`, `lineSpacing`, `locale`,
`managedObjectContext`, `menuOrder`, `minimumScaleFactor`, `multilineTextAlignment`, `openURL`, `redactionReasons`,
`scenePhase`, `scrollDismissesKeyboardMode`, `symbolRenderingMode`, `symbolVariants`, `textCase`, `timeZone`,
`truncationMode` and `verticalSizeClass`.

The `controlSize`, `editMode`, `horizontalScrollBounceBehavior`, `verticalScrollBounceBehavior` and
`menuIndicatorVisibility` cases exist but do not change the environment yet.

## Development

- `swift build --build-tests && swift test` on the Mac builds the (empty) host module.
- `xcodebuild test -scheme EnvironmentVariationPreview -destination 'platform=iOS Simulator,name=iPhone 16'` runs the
  tests, including `ReadmeTests`, which mirror the snippets above.
- `swift test --package-path Architecture` runs the [architecture rules](docs/architecture-rules.md), written with
  [swift-llm-check](https://github.com/mackoj/swift-llm-check). Conventions are in [CODING_STANDARDS.md](CODING_STANDARDS.md).
- [docs/performance.md](docs/performance.md) explains why there is no benchmark package.

## Contributing

Issues and pull requests are welcome. Keep a change small, follow [CODING_STANDARDS.md](CODING_STANDARDS.md), and add
a test for a new environment value's caption.

## License

MIT. See [LICENSE](LICENSE).
