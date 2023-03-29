# EnvironmentVariationPreview

EnvironmentVariationPreview is a SwiftUI library designed to simplify the process of previewing your SwiftUI views in a variety of environments. The code of this library work exclusively with the simulator.

### Why

Maintaining an app that must work across diverse environments (such as varying dynamic sizes, appearances, accessibility settings, locales, screen sizes, etc.) can be challenging. One way to address this issue is through [snapshot testing](https://github.com/doordash-oss/swiftui-preview-snapshots), which enables you to capture snapshots of all possible configurations and compare them to expected results to prevent regressions. EnvironmentVariationPreview was created to facilitate snapshot testing for your UI library and to provide a streamlined approach for testing your UI against different environment settings.

## Features

- Effortlessly modify the rendering of SwiftUI previews with a wide range of environment values.
- Extensive support for various environment values, including accessibility settings, color schemes, fonts, layout direction, and more.
- Seamless integration with your SwiftUI projects, enhancing your development workflow.

## Installation

### Swift Package Manager

To add SwiftUI Environment Value Preview to your project using Swift Package Manager, add the following dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/mackoj/EnvironmentVariationPreview.git", from: "1.0.0")
]
```

## Usage

To use EnvironmentVariationPreview in your SwiftUI project, follow these steps:

- Import the library in your SwiftUI file: `import EnvironmentVariationPreview`
- Apply the `.environmentVariations()` view modifier to your preview.
- Provide an array of environment values you wish to preview, such as `[.colorScheme(.light), .colorScheme(.dark), .layoutDirection(.rightToLeft), .dynamicTypeSize(.xSmall), .dynamicTypeSize(.large), .dynamicTypeSize(.xxxLarge)]`.

For example:

```swift
import Foundation
import SwiftUI
import EnvironmentVariationPreview

struct MyView_Previews: PreviewProvider {
  static var previews: some View {
    MyView()
      .environmentVariations([
        .colorScheme(.light),
        .colorScheme(.dark),
        .layoutDirection(.rightToLeft),
        .dynamicTypeSize(.xSmall),
        .dynamicTypeSize(.large),
        .dynamicTypeSize(.xxxLarge)
      ])
  }
}
```

## License

SwiftUI Environment Value Preview is released under the MIT License. See LICENSE for details.

## Example

In order to make it work you just have to add a view modifier in your SwiftUI preview.

| code | Redering |
| --- | --- |
| ![honrizontal](https://user-images.githubusercontent.com/661647/228528660-6237f9e3-c913-4870-8c38-58fdd8869978.png) | <img width="1512" alt="Capture d’écran 2023-03-28 à 22 29 38" src="https://user-images.githubusercontent.com/661647/228359745-cda5eaaf-837b-4188-a125-a09a41ecdc34.png"> |
| ![vertical](https://user-images.githubusercontent.com/661647/228528750-763f6a7c-e2c0-4fe7-9bd8-499bb239f9c2.png) | <img width="400" alt="Capture d’écran 2023-03-28 à 22 28 09" src="https://user-images.githubusercontent.com/661647/228359752-1c609881-a5c0-4e09-a988-0a18972776a7.png"> |
| ![separated](https://user-images.githubusercontent.com/661647/228529029-120bb8ff-1d2c-4863-b97a-1b79b3ded761.png) | <video width="400" src="https://user-images.githubusercontent.com/661647/228359780-61f1a897-1b80-41ed-a0b8-26c6b6b5e279.mov"> |
