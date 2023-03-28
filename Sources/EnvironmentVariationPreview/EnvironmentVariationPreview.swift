import Foundation
import SwiftUI

/// `EnvironmentVariationPreview` is a `View` that allows previewing a SwiftUI `View` under different environment values.
///
/// Example usage:
/// ```swift
/// struct MyView: View {
///   var body: some View {
///     Text("Hello, World!")
///   }
/// }
///
/// struct MyView_Previews: PreviewProvider {
///   static var previews: some View {
///     EnvironmentVariationPreview(MyView()) // Use default environment values
///   }
/// }
/// ```
/// In this example, MyView is previewed using the default environment values. The resulting previews would show MyView under various environment values, including light/dark mode, right-to-left/left-to-right layout direction, and different dynamic type sizes.
@available(iOS 16.4, macOS 13.3, tvOS 14.0, watchOS 7.0, *)
struct EnvironmentVariationPreview<Value: View>: View {
  
  /// The View to preview.
  let preview: Value
  
  /// The array of EnvironmentValueItems to apply during the preview.
  let environmentValues: EnvironmentValueItemList
  
  /// Initializing EnvironmentVariationPreview
  ///
  /// - Parameters:
  ///   - environmentValues: an optional array of EnvironmentValueItem which are environment values to apply during the preview. This parameter has a default value of light colorScheme.
  ///   - viewToPreview: the SwiftUI View to preview.
  init(
    environmentValues: EnvironmentValueItemList = [.colorScheme(.light)],
    _ viewToPreview: Value
  ) {
    self.preview = viewToPreview
    self.environmentValues = environmentValues
  }
  
  /// The body of EnvironmentVariationPreview returns a Group of Views, where each view is the preview of the original viewToPreview with a single environment value applied. The Group is created using a ForEach loop that iterates through the environmentValues array.
  /// For each environmentValue, the viewToPreview is modified by calling the applyEnvironmentValue(_:) method, which applies the given environmentValue. The modified view is then further modified to add some padding, a background color and to set a display name using the previewLayout, padding, background, and previewDisplayName modifiers respectively.
  var body: some View {
    HStack {
      ForEach(environmentValues, id: \.self) { environmentValue in        
        VStack(alignment: .center, spacing: 0) {
          self.preview
            .applyEnvironmentValue(environmentValue)
            .padding()
          
          Text(environmentValue.description)
            .foregroundColor(.white)
            .font(.body.weight(.bold))
            .padding(2)
            .frame(maxWidth: .infinity)
            .background(Color.black)
        }
        .fixedSize()
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .contentShape(RoundedRectangle(cornerRadius: 4))
        .overlay {
          RoundedRectangle(cornerRadius: 4)
            .stroke(Color.black, lineWidth: 1)
        }
      }
    }
  }
}
