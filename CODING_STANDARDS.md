# Coding standards

The conventions this library already follows, written down so a change keeps them. The mechanical ones are enforced
by the `Architecture/` package (`swift test --package-path Architecture`); see `docs/architecture-rules.md`.

## Simulator only

EnvironmentVariationPreview exists for SwiftUI previews and snapshot tests. Every file in `Sources` is wrapped, whole,
in `#if targetEnvironment(simulator)` … `#endif`, so device and Mac builds compile an empty module and an app that links
the library ships none of it. Tests are wrapped the same way and run on an iOS simulator.

## No dependencies

The package depends on nothing. The library imports Foundation, SwiftUI and CoreData (for `managedObjectContext`)
only. A platform framework (UIKit, AppKit) would tie a file to one platform.

## One availability floor

`Package.swift` sets the floor: iOS 14, macOS 11, tvOS 14, watchOS 7. Every public type, and every public member of
an extension, carries `@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)`, exactly. An API newer than the
floor is reached with `if #available` inside `EnvironmentValueItem.apply(to:)`, which falls back to the unchanged
content.

## Newer types as `Any`

An environment value whose type is newer than the floor (`DynamicTypeSize`, `Material`, `MenuOrder`…) cannot appear in
a case of an enum available on iOS 14. Its case takes `Any` (or `Any?`) and names the real type in a trailing comment:
`case dynamicTypeSize(Any) // DynamicTypeSize`. `apply(to:)` casts it back under `if #available`.

## Type erasure in one place

`EnvironmentValueItem.apply(to:)` returns a different `.environment` type per case, so it erases with `AnyView`. That
is the only `AnyView` in the library; everything else returns `some View`.

## Captions name the case

`EnvironmentValueItem.description` is the caption under each variation. The string for `.name(let value)` starts with
`"name: "`, followed by the value.

## Style

Two-space indentation, as in the existing files. Public API has a DocC comment (Swift Package Index builds the
documentation, see `.spi.yml`). The package keeps `swift-tools-version: 5.7.1`: `Architecture/` and `Benchmarks/` are
separate packages so they can use newer tools without raising it. Tests use XCTest, which every supported toolchain has.
