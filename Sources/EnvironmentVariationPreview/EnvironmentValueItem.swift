#if targetEnvironment(simulator)
import Foundation
import SwiftUI
import CoreData

/// An enum representing all possible environment values that can be applied to modify the rendering of a SwiftUI preview.
///
/// - Note: This contains only modifiable properties of the SwiftUI environment, thus some elements are not available, such as:
///   - accessibilityDifferentiateWithoutColor
///   - accessibilityInvertColors
///   - accessibilityLargeContentViewerEnabled
///   - accessibilityQuickActionsEnabled
///   - accessibilityReduceMotion
///   - accessibilityReduceTransparency
///   - accessibilityShowButtonShapes
///   - accessibilitySwitchControlEnabled
///   - accessibilityVoiceOverEnabled
///   - colorSchemeContrast
///   - dismiss
///   - description
///   - dismissSearch
///   - horizontalScrollIndicatorVisibility
///   - isFocused
///   - isPresented
///   - isSearching
///   - keyboardShortcut
///   - openWindow
///   - pixelLength
///   - rename
///   - refresh
///   - supportsMultipleWindows
///   - searchSuggestionsPlacement
///   - undoManager
///   - verticalScrollIndicatorVisibility
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public enum EnvironmentValueItem {
  case accessibilityEnabled(Bool)
  case allowsTightening(Bool)
  case autocorrectionDisabled(Bool)
  case backgroundMaterial(Any?) // Material
  case backgroundStyle(Any?) // AnyShapeStyle
  case calendar(Calendar)
  case colorScheme(ColorScheme)
  case controlSize(Any) // ControlSize
  case contentTransition(Any) // ContentTransition
  case contentTransitionAddsDrawingGroup(Bool)
  case displayScale(CGFloat)
  case dynamicTypeSize(Any) // DynamicTypeSize
  case defaultMinListRowHeight(CGFloat)
  case defaultMinListHeaderHeight(CGFloat)
  case disableAutocorrection(Bool)
  case editMode(Binding<EditMode>?)
  case font(Font?)
  case headerProminence(Any) // Prominence
  case horizontalSizeClass(UserInterfaceSizeClass?)
  case horizontalScrollBounceBehavior(Any) // ScrollBounceBehavior
  case isEnabled(Bool)
  case imageScale(Image.Scale)
  case isScrollEnabled(Bool)
  case isLuminanceReduced(Bool)
  case locale(Locale)
  case lineLimit(Int?)
  case lineSpacing(CGFloat)
  case layoutDirection(LayoutDirection)
  case legibilityWeight(LegibilityWeight?)
  case menuOrder(Any) // MenuOrder
  case minimumScaleFactor(CGFloat)
  case managedObjectContext(NSManagedObjectContext)
  case multilineTextAlignment(TextAlignment)
  case menuIndicatorVisibility(Any) // Visibility
  case openURL(OpenURLAction)
  case redactionReasons(RedactionReasons)
  case scenePhase(ScenePhase)
  case symbolVariants(Any) // SymbolVariants
  case symbolRenderingMode(Any?) // SymbolRenderingMode
  case scrollDismissesKeyboardMode(Any) // ScrollDismissesKeyboardMode
  case textCase(Text.Case?)
  case timeZone(TimeZone)
  case truncationMode(Text.TruncationMode)
  case verticalSizeClass(UserInterfaceSizeClass?)
  case verticalScrollBounceBehavior(Any) // ScrollBounceBehavior
  
  /// Applies the `EnvironmentValueItem` to the given `View`'s environment.
  /// The usage of `AnyView` is not ideal but is intended to be used for previews only.
  /// When Swift Generics and ResultBuilder support this case, `AnyView` instances will be removed.
  ///
  /// - Parameter content: A `View` to which the environment value should be applied.
  /// - Returns: A view with the environment value applied.
  func apply<V: View>(to content: V) -> some View {
    switch self {
      case .accessibilityEnabled(let value): return AnyView(content.environment(\.accessibilityEnabled, value))
      case .allowsTightening(let value): return AnyView(content.environment(\.allowsTightening, value))
      case .autocorrectionDisabled(let value): return AnyView(content.environment(\.autocorrectionDisabled, value))
      case .backgroundMaterial(let value):
        if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *), let convertedValue = value as? Material {
          return AnyView(content.environment(\.backgroundMaterial, convertedValue))
        }
        return AnyView(content)
      case .backgroundStyle(let value):
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *), let convertedValue = value as? AnyShapeStyle {
          return AnyView(content.environment(\.backgroundStyle, convertedValue))
        }
        return AnyView(content)
      case .calendar(let value): return AnyView(content.environment(\.calendar, value))
      case .colorScheme(let value): return AnyView(content.environment(\.colorScheme, value))
      case .controlSize(let value):
        if #available(iOS 15.0, macOS 10.15, watchOS 9.0, *), let convertedValue = value as? ControlSize {
          return AnyView(content.environment(\.controlSize, convertedValue))
        }
        return AnyView(content)
      case .contentTransition(let value):
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *), let convertedValue = value as? ContentTransition {
          return AnyView(content.environment(\.contentTransition, convertedValue))
        }
        return AnyView(content)
      case .contentTransitionAddsDrawingGroup(let value):
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
          return AnyView(content.environment(\.contentTransitionAddsDrawingGroup, value))
        }
        return AnyView(content)
      case .displayScale(let value): return AnyView(content.environment(\.displayScale, value))
      case .dynamicTypeSize(let value):
        if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *), let convertedValue = value as? DynamicTypeSize {
          return AnyView(content.environment(\.dynamicTypeSize, convertedValue))
        }
        return AnyView(content)
      case .defaultMinListRowHeight(let value): return AnyView(content.environment(\.defaultMinListRowHeight, value))
      case .defaultMinListHeaderHeight(let value): return AnyView(content.environment(\.defaultMinListHeaderHeight, value))
      case .disableAutocorrection(let value): return AnyView(content.environment(\.disableAutocorrection, value))
      case .editMode(let value): return AnyView(content.environment(\.editMode, value))
      case .font(let value): return AnyView(content.environment(\.font, value))
      case .headerProminence(let value):
        if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *), let convertedValue = value as? Prominence {
          return AnyView(content.environment(\.headerProminence, convertedValue))
        }
        return AnyView(content)
      case .horizontalSizeClass(let value): return AnyView(content.environment(\.horizontalSizeClass, value))
      case .horizontalScrollBounceBehavior(let value):
//        if #available(iOS 16.4, macOS 13.3, tvOS 16.4, watchOS 9.4, *), let convertedValue = value as? ScrollBounceBehavior {
//          return AnyView(content.environment(\.horizontalScrollBounceBehavior, convertedValue))
//        }
        return AnyView(content)
      case .verticalScrollBounceBehavior(let value):
//        if #available(iOS 16.4, macOS 13.3, tvOS 16.4, watchOS 9.4, *), let convertedValue = value as? ScrollBounceBehavior {
//          return AnyView(content.environment(\.verticalScrollBounceBehavior, convertedValue))
//        }
        return AnyView(content)
      case .isEnabled(let value): return AnyView(content.environment(\.isEnabled, value))
      case .imageScale(let value): return AnyView(content.environment(\.imageScale, value))
      case .isScrollEnabled(let value):
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
          return AnyView(content.environment(\.isScrollEnabled, value))
        }
        return AnyView(content)
      case .isLuminanceReduced(let value):
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
          return AnyView(content.environment(\.isLuminanceReduced, value))
        }
        return AnyView(content)
      case .locale(let value): return AnyView(content.environment(\.locale, value))
      case .lineLimit(let value): return AnyView(content.environment(\.lineLimit, value))
      case .lineSpacing(let value): return AnyView(content.environment(\.lineSpacing, value))
      case .layoutDirection(let value): return AnyView(content.environment(\.layoutDirection, value))
      case .legibilityWeight(let value): return AnyView(content.environment(\.legibilityWeight, value))
      case .menuOrder(let value):
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *), let convertedValue = value as? MenuOrder {
          return AnyView(content.environment(\.menuOrder, convertedValue))
        }
        return AnyView(content)
      case .minimumScaleFactor(let value): return AnyView(content.environment(\.minimumScaleFactor, value))
      case .managedObjectContext(let value): return AnyView(content.environment(\.managedObjectContext, value))
      case .multilineTextAlignment(let value): return AnyView(content.environment(\.multilineTextAlignment, value))
      case .menuIndicatorVisibility(let value):
        if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *), let convertedValue = value as? Visibility {
          return AnyView(content.environment(\.menuIndicatorVisibility, convertedValue))
        }
        return AnyView(content)
      case .openURL(let value):
        if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *) {
//        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
          return AnyView(content.environment(\.openURL, value))
        }
        return AnyView(content)
      case .redactionReasons(let value): return AnyView(content.environment(\.redactionReasons, value))
      case .scenePhase(let value): return AnyView(content.environment(\.scenePhase, value))
      case .symbolVariants(let value):
        if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *), let convertedValue = value as? SymbolVariants {
          return AnyView(content.environment(\.symbolVariants, convertedValue))
        }
        return AnyView(content)
      case .symbolRenderingMode(let value):
        if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *), let convertedValue = value as? SymbolRenderingMode {
          return AnyView(content.environment(\.symbolRenderingMode, convertedValue))
        }
        return AnyView(content)
      case .scrollDismissesKeyboardMode(let value):
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *), let convertedValue = value as? ScrollDismissesKeyboardMode {
          return AnyView(content.environment(\.scrollDismissesKeyboardMode, convertedValue))
        }
        return AnyView(content)
      case .textCase(let value): return AnyView(content.environment(\.textCase, value))
      case .timeZone(let value): return AnyView(content.environment(\.timeZone, value))
      case .truncationMode(let value): return AnyView(content.environment(\.truncationMode, value))
      case .verticalSizeClass(let value): return AnyView(content.environment(\.verticalSizeClass, value))
    }
  }
  
  /// A computed property that returns a description of the environment value, used for setting the preview's title.
  var description: String {
    switch self {
      case .accessibilityEnabled(let value): return "accessibilityEnabled: \(value)"
      case .allowsTightening(let value): return "allowsTightening: \(value)"
      case .autocorrectionDisabled(let value): return "autocorrectionDisabled: \(value)"
      case .backgroundMaterial(let value): return "backgroundMaterial: \(value.debugDescription)"
      case .backgroundStyle(let value): return "backgroundStyle: \(value.debugDescription)"
      case .calendar(let value): return "calendar: \(value)"
      case .colorScheme(let value): return "colorScheme: \(value)"
      case .controlSize(let value): return "controlSize: \(value)"
      case .contentTransition(let value): return "contentTransition: \(value)"
      case .contentTransitionAddsDrawingGroup(let value): return "contentTransitionAddsDrawingGroup: \(value)"
      case .displayScale(let value): return "displayScale: \(value)"
      case .dynamicTypeSize(let value): return "dynamicTypeSize: \(value)"
      case .defaultMinListRowHeight(let value): return "defaultMinListRowHeight: \(value)"
      case .defaultMinListHeaderHeight(let value): return "defaultMinListHeaderHeight: \(value)"
      case .disableAutocorrection(let value): return "disableAutocorrection: \(value)"
      case .editMode(let value): return "editMode: \(value.debugDescription)"
      case .font(let value): return "font: \(value.debugDescription)"
      case .headerProminence(let value): return "headerProminence: \(value)"
      case .horizontalSizeClass(let value): return "horizontalSizeClass: \(value.debugDescription)"
      case .isEnabled(let value): return "isEnabled: \(value)"
      case .imageScale(let value): return "imageScale: \(value)"
      case .isScrollEnabled(let value): return "isScrollEnabled: \(value)"
      case .isLuminanceReduced(let value): return "isLuminanceReduced: \(value)"
      case .locale(let value): return "locale: \(value)"
      case .lineLimit(let value): return "lineLimit: \(value.debugDescription)"
      case .lineSpacing(let value): return "lineSpacing: \(value)"
      case .layoutDirection(let value): return "layoutDirection: \(value)"
      case .legibilityWeight(let value): return "legibilityWeight: \(value?.description ?? "nil")"
      case .menuOrder(let value): return "menuOrder: \(value)"
      case .minimumScaleFactor(let value): return "minimumScaleFactor: \(value)"
      case .managedObjectContext(let value): return "managedObjectContext: \(value)"
      case .multilineTextAlignment(let value): return "multilineTextAlignment: \(value)"
      case .menuIndicatorVisibility(let value): return "menuIndicatorVisibility: \(value)"
      case .openURL(let value): return "openURL: \(value)"
      case .redactionReasons(let value): return "redactionReasons: \(value)"
      case .scenePhase(let value): return "scenePhase: \(value)"
      case .symbolVariants(let value): return "symbolVariants: \(value)"
      case .symbolRenderingMode(let value): return "symbolRenderingMode: \(value.debugDescription)"
      case .scrollDismissesKeyboardMode(let value): return "scrollDismissesKeyboardMode: \(value)"
      case .textCase(let value): return "textCase: \(value.debugDescription)"
      case .timeZone(let value): return "timeZone: \(value)"
      case .truncationMode(let value): return "truncationMode: \(value)"
      case .verticalSizeClass(let value): return "verticalSizeClass: \(value.debugDescription)"
      case .horizontalScrollBounceBehavior(let value): return "horizontalScrollBounceBehavior: \(value)"
      case .verticalScrollBounceBehavior(let value): return "verticalScrollBounceBehavior: \(value)"
    }
  }
}

extension EnvironmentValueItem {
  @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
  var colorScheme: ColorScheme? {
    switch self {
      case .colorScheme(let value): return value
      default: return nil
    }
  }
}
#endif
