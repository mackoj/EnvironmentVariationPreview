# EnvironmentVariationPreview

This is a library that makes it easier to apply environment values to SwiftUI previews.

## Features

- Modify the rendering of SwiftUI previews using a wide range of environment values.
- Supports a variety of environment values for previews, including accessibility settings, color schemes, fonts, layout direction, and more.
- Easy to integrate into your SwiftUI projects.

## Installation

### Swift Package Manager

To add SwiftUI Environment Value Preview to your project using Swift Package Manager, add the following dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/SwiftUIEnvironmentValuePreview.git", from: "1.0.0")
]
```

## Usage

- Import the library in your SwiftUI file: `import SwiftUIEnvironmentValuePreview`
- Use the EnvironmentValueItem enum to create an instance of the environment value you want to apply to the preview. `let colorSchemeDark = EnvironmentValueItem.colorScheme(.dark)`
- Apply the environment value to your preview using the applyEnvironmentValue(_:) method ``
- Customize your SwiftUI previews with different environment values as needed.

## License

SwiftUI Environment Value Preview is released under the MIT License. See LICENSE for details.

## Example

| code | Redering |
| --- | --- |
| ```swift
import Foundation
import SwiftUI

struct Previews_Test_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      Label("Variation Preview", systemImage: "basketball")
        .fontWeight(.bold)
        .foregroundColor(Color("fg", bundle: .module))
        .padding()
        .background(Color("bg", bundle: .module))
        .cornerRadius(4)
        .environmentVariations([ .colorScheme(.light), .colorScheme(.dark), .layoutDirection(.rightToLeft), .dynamicTypeSize(.xSmall), .dynamicTypeSize(.large), .dynamicTypeSize(.xxxLarge)])
        .previewLayout(.sizeThatFits)
    }
  }
}
``` | <img width="1512" alt="Capture d’écran 2023-03-28 à 22 29 38" src="https://user-images.githubusercontent.com/661647/228359745-cda5eaaf-837b-4188-a125-a09a41ecdc34.png"> |

<img width="400" alt="Capture d’écran 2023-03-28 à 22 28 09" src="https://user-images.githubusercontent.com/661647/228359752-1c609881-a5c0-4e09-a988-0a18972776a7.png">

https://user-images.githubusercontent.com/661647/228359780-61f1a897-1b80-41ed-a0b8-26c6b6b5e279.mov

