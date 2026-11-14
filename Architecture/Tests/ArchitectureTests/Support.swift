import LLMCheck

/// The EnvironmentVariationPreview repository, rooted where `.llm-check.yaml` is. Its file list and every parsed file
/// are shared by all suites, which Swift Testing runs in parallel.
func repository() throws -> Codebase { try Codebase() }

/// The availability every public declaration names: the `platforms` floor in `Package.swift`.
let packageFloor = "iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *"

extension RuleCategory {
    static let platforms = RuleCategory(
        "platforms",
        description: """
            Simulator-only code, imports and availability. Read before you add a file, an `import` or an \
            `@available` to `Sources`.
            """
    )
    static let environmentValues = RuleCategory(
        "environment-values",
        description: "`EnvironmentValueItem` and how it is applied. Read before you add or change an environment value."
    )
}
