import LLMCheck
import Testing

/// The rules, run on the repository. A failure prints the rule, why it exists and how to fix it.
@Suite("Architecture rules")
struct ArchitectureRules {
    static func sources() throws -> Scope { try repository().productionCode.in("/Sources") }

    @Test func sourcesAreSimulatorOnly() throws {
        let sources = try Self.sources()
        #expect(sources.relativePaths.count > 5)
        expectNone(Detect.codeOutsideSimulatorGuard(in: sources), rule: .sourcesAreSimulatorOnly)
    }

    @Test func importsStayWithinBudget() throws {
        expectNone(Detect.importsOverBudget(in: try Self.sources()), rule: .importsStayWithinBudget)
    }

    @Test func availabilityNamesThePackageFloor() throws {
        let found = Detect.availabilityOffTheFloor(in: try Self.sources(), floor: packageFloor)
        expectNone(found, rule: .availabilityNamesThePackageFloor)
    }

    @Test func publicTypesDeclareAvailability() throws {
        let sources = try Self.sources()
        #expect(sources.declarations.withModifier("public").count > 10)
        expectNone(Detect.publicDeclarationsWithoutAvailability(in: sources), rule: .publicTypesDeclareAvailability)
    }

    @Test func anyViewStaysInApply() throws {
        let sources = try Self.sources()
        #expect(sources.references(to: "AnyView").count > 40)
        expectNone(Detect.anyViewOutsideApply(in: sources), rule: .anyViewStaysInApply)
    }

    @Test func erasedPayloadsNameTheirType() throws {
        expectNone(Detect.erasedPayloadsWithoutTypeComment(in: try Self.sources()), rule: .erasedPayloadsNameTheirType)
    }

    @Test func descriptionsNameTheirCase() throws {
        let sources = try Self.sources()
        #expect(sources.containing("var description").relativePaths.count >= 2)
        expectNone(Detect.descriptionsNamingAnotherCase(in: sources), rule: .descriptionsNameTheirCase)
    }
}

/// Keeps `docs/architecture-rules.md` in step with the rules. Regenerate with
/// `LLM_CHECK_RECORD=1 swift test --package-path Architecture`.
@Test func rulesDocumentIsUpToDate() throws {
    let catalog = RuleCatalog(allRules)
    #expect(catalog.duplicateIDs.isEmpty)
    try expectFile(
        "docs/architecture-rules.md", in: repository(),
        matches: catalog.markdown(
            title: "Architecture rules",
            introduction: """
                The mechanical part of `CODING_STANDARDS.md`, enforced by the `Architecture/` package with \
                [swift-llm-check](https://github.com/mackoj/swift-llm-check): \
                `swift test --package-path Architecture` (macOS). Generated from its rules; do not edit by hand.
                """))
}
