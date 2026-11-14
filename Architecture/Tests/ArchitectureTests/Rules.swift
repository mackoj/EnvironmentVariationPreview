import LLMCheck

extension Rule {
    static let sourcesAreSimulatorOnly = Rule(
        id: "sources-are-simulator-only",
        title: "Every file in `Sources` is wrapped, whole, in `#if targetEnvironment(simulator)`.",
        category: .platforms,
        rationale: """
            EnvironmentVariationPreview is a preview tool (CODING_STANDARDS.md, "Simulator only"): apps link it \
            from their UI modules, so whatever it compiles on a device ships in the App Store binary. Wrapping every \
            file keeps device and Mac builds empty, so the library costs nothing outside the simulator and the \
            canvas. A declaration outside the guard is compiled, and shipped, everywhere.
            """,
        howToFix: """
            Put the whole file, imports included, between `#if targetEnvironment(simulator)` on the first line and \
            `#endif` on the last, with no `#else`, like `Sources/EnvironmentVariationPreview/EnvironmentVariations.swift`.
            """,
        badExample: """
            import Foundation

            extension Locale { … }
            """,
        goodExample: """
            #if targetEnvironment(simulator)
            import Foundation

            extension Locale { … }
            #endif
            """
    )

    static let importsStayWithinBudget = Rule(
        id: "imports-stay-within-budget",
        title: "The library imports only Foundation, SwiftUI and CoreData.",
        category: .platforms,
        rationale: """
            The package has no dependencies and must build on every platform it lists (CODING_STANDARDS.md, \
            "No dependencies"). CoreData is there for the `managedObjectContext` environment value; UIKit or AppKit \
            would tie a file to one platform, and any other module is a new dependency for every client.
            """,
        howToFix: """
            Use SwiftUI or Foundation API. If an environment value needs a platform framework, wrap the case and its \
            import in `#if canImport(…)` and add the module to this rule's budget in the same pull request.
            """,
        badExample: "import UIKit",
        goodExample: "import SwiftUI"
    )

    static let availabilityNamesThePackageFloor = Rule(
        id: "availability-names-the-package-floor",
        title: "Every `@available` that names platforms names the package floor: iOS 14, macOS 11, tvOS 14, watchOS 7.",
        category: .platforms,
        rationale: """
            The `platforms` in `Package.swift` are the floor, and the `@available` attributes repeat it so the DocC \
            pages and Xcode's quick help say where each API works. One attribute with another floor, such as \
            `@available(iOS 13.0, *)`, documents a version the package cannot be used on and forgets the other \
            platforms. Newer APIs are reached with `if #available` inside `EnvironmentValueItem.apply`, not with a \
            higher `@available` (CODING_STANDARDS.md, "One availability floor").
            """,
        howToFix: "Write `@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)` exactly.",
        badExample: "@available(iOS 13.0, *)\nextension LegibilityWeight: CustomStringConvertible {",
        goodExample: """
            @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
            extension LegibilityWeight: CustomStringConvertible {
            """
    )

    static let publicTypesDeclareAvailability = Rule(
        id: "public-types-declare-availability",
        title: "A public type, or a public member of an extension, carries `@available` itself or through its extension.",
        category: .platforms,
        rationale: """
            Without the attribute, DocC and quick help show the declaration as available everywhere, and the floor \
            in the generated documentation drifts from `Package.swift` (CODING_STANDARDS.md, "One availability \
            floor"). Members of a type that has the attribute inherit it.
            """,
        howToFix: "Add `@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)` to the type, extension or member.",
        badExample: """
            extension View {
              public func environmentVariations(_ variarions: EnvironmentValueItemList) -> some View {
            """,
        goodExample: """
            extension View {
              @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
              public func environmentVariations(_ variarions: EnvironmentValueItemList) -> some View {
            """
    )

    static let anyViewStaysInApply = Rule(
        id: "any-view-stays-in-apply",
        title: "`AnyView` appears only in `EnvironmentValueItem.apply(to:)`.",
        category: .environmentValues,
        rationale: """
            `apply(to:)` returns a different `.environment` type per case, and Swift's result builders cannot \
            return them from one `switch` without erasing, so that one function erases (CODING_STANDARDS.md, \
            "Type erasure in one place"). Anywhere else `AnyView` hides the view's identity from SwiftUI's diffing \
            and is avoidable with `some View` or `@ViewBuilder`.
            """,
        howToFix: "Return `some View`, or mark the function `@ViewBuilder` and let it build a `_ConditionalContent`.",
        badExample: "func body(content: Content) -> some View { AnyView(content.padding()) }",
        goodExample: "func body(content: Content) -> some View { content.padding() }"
    )

    static let erasedPayloadsNameTheirType = Rule(
        id: "erased-payloads-name-their-type",
        title: "An `EnvironmentValueItem` case whose payload is `Any` or `Any?` names the real type in a trailing comment.",
        category: .environmentValues,
        rationale: """
            Types newer than the floor, such as `DynamicTypeSize` (iOS 15), cannot appear in a case of an enum \
            available on iOS 14, so their payload is `Any` and `apply(to:)` casts it back under `if #available` \
            (CODING_STANDARDS.md, "Newer types as Any"). The comment is the only place that says what the cast \
            expects; a caller who passes anything else gets the content back unchanged, silently.
            """,
        howToFix: "End the case with `// TypeName`, the SwiftUI type that `apply(to:)` casts the payload to.",
        badExample: "case dynamicTypeSize(Any)",
        goodExample: "case dynamicTypeSize(Any) // DynamicTypeSize"
    )

    static let descriptionsNameTheirCase = Rule(
        id: "descriptions-name-their-case",
        title: "In a `description` switch, the string for `.name(let value)` starts with `\"name: \"`.",
        category: .environmentValues,
        rationale: """
            The description is the caption under each variation in the preview canvas, and the only thing that \
            tells two otherwise identical renders apart. A caption that names another case, such as one copied \
            from the line above, labels the screenshot wrong (CODING_STANDARDS.md, "Captions name the case").
            """,
        howToFix: "Start the string with the case's name, a colon and a space, then interpolate the payload.",
        badExample: "case .verticalSizeClass(let value): return \"horizontalSizeClass: \\(value.debugDescription)\"",
        goodExample: "case .verticalSizeClass(let value): return \"verticalSizeClass: \\(value.debugDescription)\""
    )
}

/// Every rule, in the order `docs/architecture-rules.md` lists them.
let allRules: [Rule] = [
    .sourcesAreSimulatorOnly, .importsStayWithinBudget, .availabilityNamesThePackageFloor,
    .publicTypesDeclareAvailability, .anyViewStaysInApply, .erasedPayloadsNameTheirType, .descriptionsNameTheirCase,
]
