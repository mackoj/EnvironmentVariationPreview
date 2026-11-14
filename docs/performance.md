# Performance

The short version: there is no hot path in EnvironmentVariationPreview, so there is no `Benchmarks/` package and no
performance change. This page records how that was checked, so the question does not need asking again.

## Why there is no benchmark package

The other mackoj packages measure with [package-benchmark](https://github.com/ordo-one/package-benchmark), which runs
a benchmark executable on the host: macOS or Linux. Every file in this library is wrapped in
`#if targetEnvironment(simulator)` (see `CODING_STANDARDS.md`), so on the host the module is empty: there is nothing
for a benchmark to call. A package-benchmark target cannot run inside the iOS simulator.

## What the library does, measured where it runs

The library's work is small and happens once per preview render:

1. `EnvironmentValueItemList(arrayLiteral:)` wraps each `EnvironmentValueItem` in a `HashableEnvironmentValueItem`,
   which makes one `UUID`.
2. `EnvironmentVariationsModifier.body` builds a `ForEach` of `VStack`s, one per item.
3. Per item, `EnvironmentValueItem.apply(to:)` wraps the content in one `.environment` modifier and one `AnyView`, and
   `description` builds the caption string.

Measured once, on an iPhone 17 simulator (iOS 27, Xcode 27.2, Debug build, Apple silicon), with a throwaway XCTest
that took the median of 200 runs (50 for the hosting rows). Eight variations: light, dark, right-to-left, three dynamic
type sizes, a locale and a legibility weight.

| What | p50 |
| --- | ---: |
| Build an `EnvironmentValueItemList` of 8 items (8 `UUID`s) | 4.7 µs |
| Build the 8 captions (`description`) | 10.3 µs |
| Apply `.environmentVariations` to a `Text` (value construction only) | 4.6 µs |
| Host and lay out the 8 variations in a `UIHostingController` | 113 µs |
| Baseline: host and lay out 8 plain padded `Text`s, no library | 97 µs |

The library adds about 16 µs to a render that SwiftUI itself spends about 100 µs on, and the preview canvas spends
milliseconds compiling and launching around it. Rewriting `apply(to:)` without `AnyView` or caching captions would
save microseconds nobody can see.

## What has paid off

Nothing yet: no change was made for speed or memory, because none would be measurable by a user.

## Not changed on purpose

`HashableEnvironmentValueItem` makes a new `UUID` every time a list is built, and `.environmentVariations()` builds its
default list on each call. So when a preview's parent re-evaluates its body, every variation gets a new identity and
SwiftUI rebuilds it rather than updating it, which also resets any `@State` inside the previewed view. Making the
identity stable (for example from the item's position) would change the public `id` and `Hashable` semantics of
`HashableEnvironmentValueItem`, so it is a behaviour change for a major or minor release, not a performance patch. In a
static preview, which is what the library is for, it costs nothing.

## Measuring again

If the library grows real work (say, generating combinations of values), add a `Benchmarks/` package that compiles the
pure part without the simulator guard, as the other mackoj packages do, and record the p50 table here. Until then, a
throwaway XCTest on a simulator, like the one above, is the honest tool:

```swift
func p50(_ runs: Int = 200, _ body: () -> Void) -> Double {
  var samples: [Double] = []
  for _ in 0..<runs {
    let start = DispatchTime.now().uptimeNanoseconds
    body()
    samples.append(Double(DispatchTime.now().uptimeNanoseconds - start) / 1000)
  }
  return samples.sorted()[runs / 2]  // microseconds
}
```
