# EnvironmentVariationPreview

EnvironmentVariationPreview is a SwiftUI library designed to simplify the process of previewing your SwiftUI views in a variety of environments. The code of this library work exclusively with the simulator.

| video | image |
| --- | --- |
| <video height="640" src="https://user-images.githubusercontent.com/661647/228359780-61f1a897-1b80-41ed-a0b8-26c6b6b5e279.mov"> | <img height="640" alt="Capture d’écran 2023-03-28 à 22 28 09" src="https://user-images.githubusercontent.com/661647/228359752-1c609881-a5c0-4e09-a988-0a18972776a7.png"> |

### Why

Maintaining an app that must work across diverse environments (such as varying dynamic sizes, appearances, accessibility settings, locales, screen sizes, etc.) can be challenging. One way to address this issue is through [snapshot testing](https://github.com/doordash-oss/swiftui-preview-snapshots), which enables you to capture snapshots of all possible configurations and compare them to expected results to prevent regressions. EnvironmentVariationPreview was created to facilitate snapshot testing for your UI library and to provide a streamlined approach for testing your UI against different environment settings.

<img width="1512" alt="Capture d’écran 2023-03-28 à 22 29 38" src="https://user-images.githubusercontent.com/661647/228359745-cda5eaaf-837b-4188-a125-a09a41ecdc34.png">

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

In order to make it work you just have to add a view modifier in your SwiftUI preview.

## License

SwiftUI Environment Value Preview is released under the MIT License. See LICENSE for details.

## Contributing

We welcome contributions from the community to help improve and expand EnvironmentVariationPreview. If you'd like to contribute, please follow these steps:

- Fork the repository on GitHub.
- Create a new branch with a descriptive name, e.g., feature/new-environment-value.
- Implement your changes or bug fixes, ensuring that your code is clean and well-documented.
- Submit a pull request, detailing your changes and the purpose behind them.
- Make sure to keep your pull request up-to-date with the base branch, resolving any conflicts that may arise.
- By contributing, you agree that your contributions will be licensed under the same license as the original project.

If you have any questions or need help, feel free to open an issue or reach out to the maintainers. We appreciate your support!
