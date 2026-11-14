import Foundation
import LLMCheck
import SwiftSyntax

/// The detectors, separate from the codebase so `DetectorTests` can run them on snippets.
enum Detect {
    /// Top-level code outside one whole-file `#if targetEnvironment(simulator)` with no `#else`. A file that is not
    /// guarded at all is reported at its first statement; a guarded file at whatever sits beside the guard.
    static func codeOutsideSimulatorGuard(in scope: Scope) -> [Match<Syntax>] {
        scope.files.flatMap { file -> [Match<Syntax>] in
            file.syntax.statements.compactMap { statement in
                if let guarded = statement.item.as(IfConfigDeclSyntax.self), isSimulatorGuard(guarded) { return nil }
                return Match(node: Syntax(statement), file: file)
            }
        }
    }

    private static func isSimulatorGuard(_ node: IfConfigDeclSyntax) -> Bool {
        node.clauses.count == 1 && node.clauses.first?.condition?.trimmedDescription == "targetEnvironment(simulator)"
    }

    /// What the library may import.
    static let allowedModules: Set<String> = ["Foundation", "SwiftUI", "CoreData"]

    /// Imports of any other module.
    static func importsOverBudget(in scope: Scope) -> [Match<ImportDeclSyntax>] {
        scope.imports.filter { !allowedModules.contains($0.node.moduleName) }
    }

    /// Platform names that make an `@available` a statement about the floor.
    static let platformNames = ["iOS", "macOS", "tvOS", "watchOS", "visionOS", "macCatalyst"]

    /// `@available(…)` attributes that name a platform but not exactly the package floor.
    static func availabilityOffTheFloor(in scope: Scope, floor: String) -> [Match<AttributeSyntax>] {
        scope.containing("@available").nodes(of: AttributeSyntax.self) { match in
            guard match.node.attributeName.trimmedDescription == "available",
                let arguments = match.node.arguments?.trimmedDescription
            else { return false }
            let namesPlatform = arguments.split(whereSeparator: { !$0.isLetter }).contains {
                platformNames.contains(String($0))
            }
            return namesPlatform && arguments != floor
        }
    }

    /// Public types without `@available`, and public members of extensions when neither has it.
    static func publicDeclarationsWithoutAvailability(in scope: Scope) -> [Declaration] {
        scope.declarations.filter { declaration in
            guard declaration.hasModifier("public"), !declaration.hasAttribute("available") else { return false }
            switch declaration.kind {
            case .struct, .class, .enum, .actor, .protocol:
                return true
            case .function, .initializer, .variable:
                guard let parent = declaration.parent, parent.kind == .extension else { return false }
                return !parent.hasAttribute("available")
            default:
                return false
            }
        }
    }

    /// `AnyView` anywhere but inside `EnvironmentValueItem.apply`.
    static func anyViewOutsideApply(in scope: Scope) -> [Match<Syntax>] {
        scope.references(to: "AnyView").filter { !$0.declarationNames.contains("EnvironmentValueItem.apply") }
    }

    /// Enum cases with an `Any` or `Any?` parameter and no `// TypeName` comment after them on the same line. A type
    /// name is UpperCamelCase, so `// TODO` is not one.
    static func erasedPayloadsWithoutTypeComment(in scope: Scope) -> [Match<EnumCaseDeclSyntax>] {
        scope.containing("case").nodes(of: EnumCaseDeclSyntax.self) { match in
            let erased = match.node.elements.contains { element in
                element.parameterClause?.parameters.contains {
                    ["Any", "Any?"].contains($0.type.trimmedDescription)
                } ?? false
            }
            guard erased else { return false }
            let trailing = match.node.lastToken(viewMode: .sourceAccurate)?.trailingTrivia ?? []
            return !trailing.contains { piece in
                guard case .lineComment(let text) = piece else { return false }
                let name = text.dropFirst(2).trimmingCharacters(in: .whitespaces)
                return name.first?.isUppercase == true && name.contains(where: \.isLowercase)
                    && name.allSatisfy { $0.isLetter || $0.isNumber || $0 == "." }
            }
        }
    }

    /// In the `switch` of a `description` property, `case .name(…)` whose first string literal does not start with
    /// `"name: "`. Cases without a payload (`case .regular:`) are not checked.
    static func descriptionsNamingAnotherCase(in scope: Scope) -> [Match<SwitchCaseSyntax>] {
        scope.containing("description").nodes(of: SwitchCaseSyntax.self) { match in
            guard isInDescription(match.node), let name = payloadCaseName(match.node) else { return false }
            guard let literal = match.node.statements.firstDescendant(of: StringLiteralExprSyntax.self),
                let first = literal.segments.first?.as(StringSegmentSyntax.self)
            else { return true }
            return !first.content.text.hasPrefix("\(name): ")
        }
    }

    private static func isInDescription(_ node: some SyntaxProtocol) -> Bool {
        sequence(first: Syntax(node), next: \.parent).contains {
            $0.as(PatternBindingSyntax.self)?.pattern.trimmedDescription == "description"
        }
    }

    /// `name` for `case .name(let value):`; nil for anything else.
    private static func payloadCaseName(_ node: SwitchCaseSyntax) -> String? {
        guard let item = node.label.as(SwitchCaseLabelSyntax.self)?.caseItems.first,
            let pattern = item.pattern.as(ExpressionPatternSyntax.self),
            let call = pattern.expression.as(FunctionCallExprSyntax.self),
            let member = call.calledExpression.as(MemberAccessExprSyntax.self), member.base == nil
        else { return nil }
        return member.declName.baseName.text
    }
}

extension SyntaxProtocol {
    /// The first node of a type under this one, in source order.
    fileprivate func firstDescendant<Node: SyntaxProtocol>(of type: Node.Type) -> Node? {
        for child in children(viewMode: .sourceAccurate) {
            if let node = child.as(Node.self) { return node }
            if let node = child.firstDescendant(of: type) { return node }
        }
        return nil
    }
}
