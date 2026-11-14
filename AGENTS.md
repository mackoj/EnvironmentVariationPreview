# Agent notes

`EnvironmentVariationPreview` is a SwiftUI library, not an app: one view modifier, `.environmentVariations([...])`,
that renders a view once per environment value (color scheme, dynamic type, layout direction, locale…) with a caption.
It compiles only for the simulator. Usage is in `README.md`.

Read `CODING_STANDARDS.md` before writing code.

## How to work
- **Smallest diff.** Every changed line traces to the request. Match the surrounding file's idioms (two-space indent,
  DocC comments on public API).
- **Test first.** A bug gets a failing test; a new environment value gets a description test.
- A new environment value is a new `EnvironmentValueItem` case plus its branch in `apply(to:)` and in `description`.

## Docs travel with code
- `README.md` is the user documentation; DocC comments are the API reference (Swift Package Index, see `.spi.yml`).
- `site/index.html` is the landing page (GitHub Pages, `.github/workflows/pages.yml`). Its code samples and install
  snippet repeat the README: update them in the same change.

## Build and test
- Host: `swift build --build-tests && swift test` builds an empty module (everything is simulator-only), which checks
  the package resolves and the guards are intact.
- Simulator: `xcodebuild test -scheme EnvironmentVariationPreview -destination 'platform=iOS Simulator,name=<iPhone>'`
  runs the real tests. CI also builds for tvOS, watchOS and visionOS simulators.
- Architecture rules: `swift test --package-path Architecture` (macOS only) runs the mechanical part of
  `CODING_STANDARDS.md` as [swift-llm-check](https://github.com/mackoj/swift-llm-check) rules, listed in
  `docs/architecture-rules.md`. A failure prints the rule, why it exists and how to fix it: fix the code, never add a
  baseline. A new or changed rule needs a `DetectorTests` case and
  `LLM_CHECK_RECORD=1 swift test --package-path Architecture` to regenerate the document.
- Releases: tags are bare semver (`1.1.4`, no `v`), created with `gh release create`.
