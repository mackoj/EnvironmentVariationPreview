# Architecture rules

The mechanical part of `CODING_STANDARDS.md`, enforced by the `Architecture/` package with [swift-llm-check](https://github.com/mackoj/swift-llm-check): `swift test --package-path Architecture` (macOS). Generated from its rules; do not edit by hand.

## platforms

Simulator-only code, imports and availability. Read before you add a file, an `import` or an `@available` to `Sources`.

### Every file in `Sources` is wrapped, whole, in `#if targetEnvironment(simulator)`.

`sources-are-simulator-only`: EnvironmentVariationPreview is a preview tool (CODING_STANDARDS.md, "Simulator only"): apps link it from their UI modules, so whatever it compiles on a device ships in the App Store binary. Wrapping every file keeps device and Mac builds empty, so the library costs nothing outside the simulator and the canvas. A declaration outside the guard is compiled, and shipped, everywhere.

**How to fix:** Put the whole file, imports included, between `#if targetEnvironment(simulator)` on the first line and `#endif` on the last, with no `#else`, like `Sources/EnvironmentVariationPreview/EnvironmentVariations.swift`.

Bad:

```swift
import Foundation

extension Locale { … }
```

Good:

```swift
#if targetEnvironment(simulator)
import Foundation

extension Locale { … }
#endif
```

### The library imports only Foundation, SwiftUI and CoreData.

`imports-stay-within-budget`: The package has no dependencies and must build on every platform it lists (CODING_STANDARDS.md, "No dependencies"). CoreData is there for the `managedObjectContext` environment value; UIKit or AppKit would tie a file to one platform, and any other module is a new dependency for every client.

**How to fix:** Use SwiftUI or Foundation API. If an environment value needs a platform framework, wrap the case and its import in `#if canImport(…)` and add the module to this rule's budget in the same pull request.

Bad:

```swift
import UIKit
```

Good:

```swift
import SwiftUI
```

### Every `@available` that names platforms names the package floor: iOS 14, macOS 11, tvOS 14, watchOS 7.

`availability-names-the-package-floor`: The `platforms` in `Package.swift` are the floor, and the `@available` attributes repeat it so the DocC pages and Xcode's quick help say where each API works. One attribute with another floor, such as `@available(iOS 13.0, *)`, documents a version the package cannot be used on and forgets the other platforms. Newer APIs are reached with `if #available` inside `EnvironmentValueItem.apply`, not with a higher `@available` (CODING_STANDARDS.md, "One availability floor").

**How to fix:** Write `@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)` exactly.

Bad:

```swift
@available(iOS 13.0, *)
extension LegibilityWeight: CustomStringConvertible {
```

Good:

```swift
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension LegibilityWeight: CustomStringConvertible {
```

### A public type, or a public member of an extension, carries `@available` itself or through its extension.

`public-types-declare-availability`: Without the attribute, DocC and quick help show the declaration as available everywhere, and the floor in the generated documentation drifts from `Package.swift` (CODING_STANDARDS.md, "One availability floor"). Members of a type that has the attribute inherit it.

**How to fix:** Add `@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)` to the type, extension or member.

Bad:

```swift
extension View {
  public func environmentVariations(_ variarions: EnvironmentValueItemList) -> some View {
```

Good:

```swift
extension View {
  @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
  public func environmentVariations(_ variarions: EnvironmentValueItemList) -> some View {
```

## environment-values

`EnvironmentValueItem` and how it is applied. Read before you add or change an environment value.

### `AnyView` appears only in `EnvironmentValueItem.apply(to:)`.

`any-view-stays-in-apply`: `apply(to:)` returns a different `.environment` type per case, and Swift's result builders cannot return them from one `switch` without erasing, so that one function erases (CODING_STANDARDS.md, "Type erasure in one place"). Anywhere else `AnyView` hides the view's identity from SwiftUI's diffing and is avoidable with `some View` or `@ViewBuilder`.

**How to fix:** Return `some View`, or mark the function `@ViewBuilder` and let it build a `_ConditionalContent`.

Bad:

```swift
func body(content: Content) -> some View { AnyView(content.padding()) }
```

Good:

```swift
func body(content: Content) -> some View { content.padding() }
```

### An `EnvironmentValueItem` case whose payload is `Any` or `Any?` names the real type in a trailing comment.

`erased-payloads-name-their-type`: Types newer than the floor, such as `DynamicTypeSize` (iOS 15), cannot appear in a case of an enum available on iOS 14, so their payload is `Any` and `apply(to:)` casts it back under `if #available` (CODING_STANDARDS.md, "Newer types as Any"). The comment is the only place that says what the cast expects; a caller who passes anything else gets the content back unchanged, silently.

**How to fix:** End the case with `// TypeName`, the SwiftUI type that `apply(to:)` casts the payload to.

Bad:

```swift
case dynamicTypeSize(Any)
```

Good:

```swift
case dynamicTypeSize(Any) // DynamicTypeSize
```

### In a `description` switch, the string for `.name(let value)` starts with `"name: "`.

`descriptions-name-their-case`: The description is the caption under each variation in the preview canvas, and the only thing that tells two otherwise identical renders apart. A caption that names another case, such as one copied from the line above, labels the screenshot wrong (CODING_STANDARDS.md, "Captions name the case").

**How to fix:** Start the string with the case's name, a colon and a space, then interpolate the payload.

Bad:

```swift
case .verticalSizeClass(let value): return "horizontalSizeClass: \(value.debugDescription)"
```

Good:

```swift
case .verticalSizeClass(let value): return "verticalSizeClass: \(value.debugDescription)"
```
