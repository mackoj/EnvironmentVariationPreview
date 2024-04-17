#if targetEnvironment(simulator)
import Foundation
import SwiftUI

/// A SwiftUI `View` extension that provides an `environmentVariations` function. This function accepts a list of environment values and returns a modified view that displays previews of the original view with each of the specified environment values.
///
/// - Note: This code is designed to run in the simulator environment only.
///
extension View {
  /// Applies the specified environment values to the view and returns a modified view displaying each variation.
  ///
  /// By default, `environmentVariations` will use a light and dark color scheme.
  ///
  /// - Parameters:
  ///   - variarions: A list of environment values to apply to the view. The default value is `[.colorScheme(.light), .colorScheme(.dark)]`.
  ///   - alignment: The guide for aligning the subviews in this stack. This
  ///     guide has the same vertical screen coordinate for every subview.
  ///   - spacing: The distance between adjacent subviews, or `nil` if you
  ///     want the stack to choose a default distance for each pair of
  ///     subviews.
  /// - Returns: A modified view that displays previews of the original view with each of the specified environment values.
  @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
  public func environmentVariations(
    _ variarions: EnvironmentValueItemList = [.colorScheme(.light), .colorScheme(.dark)],
    _ alignment: HorizontalAlignment = .center,
    _ spacing: CGFloat? = nil
  ) -> some View {
    self.modifier(EnvironmentVariationsModifier(variarions: variarions, alignment: alignment, spacing: spacing))
  }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
struct EnvironmentVariationsModifier: ViewModifier {
  @State var screenSize: CGSize = .zero
  @State var contentSize: CGSize = .zero

  /// The list of environment values to apply to the content view.
  let variarions: EnvironmentValueItemList
  
  /// The guide for aligning the subviews in this stack. This guide has the same vertical screen coordinate for every subview.
  let alignment: HorizontalAlignment
  
  /// The distance between adjacent subviews, or `nil` if you want the stack to choose a default distance for each pair of subviews.
  var spacing: CGFloat? = .zero

  var columns: [GridItem] {
    if screenSize == .zero || contentSize == .zero {
      return [GridItem(.flexible(), spacing: spacing), GridItem(.flexible(), spacing: spacing), GridItem(.flexible(), spacing: spacing)]
    }
    let count = screenSize.width <= contentSize.width ? 3 : Int(screenSize.width / contentSize.width)
//    let count = 3
    let width = contentSize.width < 10 ? 10 : contentSize.width
    let output = Array(0..<count).map { _ in GridItem(.flexible(maximum: width), spacing: spacing) }
    print("contentSize.width:", contentSize.width)
//    print("screenSize.width:", screenSize.width)
    print("output.count:", output.count)
    print("output:", output)
    return output
  }

  /// Returns a modified view that displays previews of the content view with each of the specified environment values.
  ///
  /// - Parameter content: The content view to which the environment values will be applied.
  /// - Returns: A modified view that displays previews of the content view with each of the specified environment values.
  func body(content: Content) -> some View {
    ScrollView {
      LazyVGrid(columns: columns, spacing: spacing) {
        ForEach(variarions, id: \.self) { environmentValue in
          VStack(alignment: alignment, spacing: spacing) {
            content
              .applyEnvironmentValue(environmentValue)
              .padding()
            
            Text(environmentValue.description)
              .foregroundColor(.white)
              .font(.body.weight(.bold))
              .padding(2)
              .frame(maxWidth: .infinity)
              .background(Color.black)
          }
          .background(environmentValue.colorScheme == .dark ? Color.black : Color.white)
          .fixedSize()
          .clipShape(RoundedRectangle(cornerRadius: 4))
          .contentShape(RoundedRectangle(cornerRadius: 4))
          .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 1), alignment: .center)
          .localReadSize { 
            if $0.width > contentSize.width {
              contentSize.width = $0.width
            }
            if $0.height > contentSize.height {
              contentSize.height = $0.height
            }
          }
        }
      }
      .localReadSize { screenSize = $0 }
      .padding()
    }

//    Group {
//      ForEach(variarions, id: \.self) { environmentValue in
//        VStack(alignment: alignment, spacing: spacing) {
//          content
//            .applyEnvironmentValue(environmentValue)
//            .padding()
//          
//          Text(environmentValue.description)
//            .foregroundColor(.white)
//            .font(.body.weight(.bold))
//            .padding(2)
//            .frame(maxWidth: .infinity)
//            .background(Color.black)
//        }
//        .background(environmentValue.colorScheme == .dark ? Color.black : Color.white)
//        .fixedSize()
//        .clipShape(RoundedRectangle(cornerRadius: 4))
//        .contentShape(RoundedRectangle(cornerRadius: 4))
//        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 1), alignment: .center)
//      }
//    }
  }
}
#endif
