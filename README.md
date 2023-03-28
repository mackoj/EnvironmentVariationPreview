# EnvironmentVariationPreview

```swift
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
```
<img width="1512" alt="Capture d’écran 2023-03-28 à 22 29 38" src="https://user-images.githubusercontent.com/661647/228359745-cda5eaaf-837b-4188-a125-a09a41ecdc34.png">
<img width="400" alt="Capture d’écran 2023-03-28 à 22 28 09" src="https://user-images.githubusercontent.com/661647/228359752-1c609881-a5c0-4e09-a988-0a18972776a7.png">

https://user-images.githubusercontent.com/661647/228359780-61f1a897-1b80-41ed-a0b8-26c6b6b5e279.mov

