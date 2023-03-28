import Foundation
import SwiftUI
import CoreData

/// This enum represent all possible value that can be applied to the environement
/// to modify the rendering of a SwiftUI preview
@available(iOS 16.4, macOS 13.3, tvOS 14.0, watchOS 7.0, *)
public enum EnvironmentValueItem {
  case accessibilityEnabled(Bool)
  case allowsTightening(Bool)
  case autocorrectionDisabled(Bool)
  case backgroundMaterial(Material?)
  case backgroundStyle(AnyShapeStyle?)
  case calendar(Calendar)
  case colorScheme(ColorScheme)
  case controlSize(ControlSize)
  case contentTransition(ContentTransition)
  case contentTransitionAddsDrawingGroup(Bool)
  case displayScale(CGFloat)
  case dynamicTypeSize(DynamicTypeSize)
  case defaultMinListRowHeight(CGFloat)
  case defaultMinListHeaderHeight(CGFloat)
  case disableAutocorrection(Bool)
  case editMode(Binding<EditMode>?)
  case font(Font?)
  case headerProminence(Prominence)
  case horizontalSizeClass(UserInterfaceSizeClass?)
  case horizontalScrollBounceBehavior(ScrollBounceBehavior)
  case isEnabled(Bool)
  case imageScale(Image.Scale)
  case isScrollEnabled(Bool)
  case isLuminanceReduced(Bool)
  case locale(Locale)
  case lineLimit(Int?)
  case lineSpacing(CGFloat)
  case layoutDirection(LayoutDirection)
  case legibilityWeight(LegibilityWeight?)
  case menuOrder(MenuOrder)
  case minimumScaleFactor(CGFloat)
  case managedObjectContext(NSManagedObjectContext)
  case multilineTextAlignment(TextAlignment)
  case menuIndicatorVisibility(Visibility)
  case openURL(OpenURLAction)
  case redactionReasons(RedactionReasons)
  case scenePhase(ScenePhase)
  case symbolVariants(SymbolVariants)
  case symbolRenderingMode(SymbolRenderingMode?)
  case scrollDismissesKeyboardMode(ScrollDismissesKeyboardMode)
  case textCase(Text.Case?)
  case timeZone(TimeZone)
  case truncationMode(Text.TruncationMode)
  case verticalSizeClass(UserInterfaceSizeClass?)
  case verticalScrollBounceBehavior(ScrollBounceBehavior)
  
  /// This apply the `EnvironmentValueItem` to the preview's `Environment`
  /// Using AnyView is not ideal but this is intented to be used for previewOnly.
  /// When the Swift Generics and ResultBuilder are strong enoght to support this case I will remove all AnyView that are currently here for compiling raison and add nothing the mecanism
  func apply<V: View>(to content: V) -> some View {
    switch self {
      case .accessibilityEnabled(let value): return AnyView(content.environment(\.accessibilityEnabled, value))
      case .allowsTightening(let value): return AnyView(content.environment(\.allowsTightening, value))
      case .autocorrectionDisabled(let value): return AnyView(content.environment(\.autocorrectionDisabled, value))
      case .backgroundMaterial(let value): return AnyView(content.environment(\.backgroundMaterial, value))
      case .backgroundStyle(let value): return AnyView(content.environment(\.backgroundStyle, value))
      case .calendar(let value): return AnyView(content.environment(\.calendar, value))
      case .colorScheme(let value): return AnyView(content.environment(\.colorScheme, value))
      case .controlSize(let value): return AnyView(content.environment(\.controlSize, value))
      case .contentTransition(let value): return AnyView(content.environment(\.contentTransition, value))
      case .contentTransitionAddsDrawingGroup(let value): return AnyView(content.environment(\.contentTransitionAddsDrawingGroup, value))
      case .displayScale(let value): return AnyView(content.environment(\.displayScale, value))
      case .dynamicTypeSize(let value): return AnyView(content.environment(\.dynamicTypeSize, value))
      case .defaultMinListRowHeight(let value): return AnyView(content.environment(\.defaultMinListRowHeight, value))
      case .defaultMinListHeaderHeight(let value): return AnyView(content.environment(\.defaultMinListHeaderHeight, value))
      case .disableAutocorrection(let value): return AnyView(content.environment(\.disableAutocorrection, value))
      case .editMode(let value): return AnyView(content.environment(\.editMode, value))
      case .font(let value): return AnyView(content.environment(\.font, value))
      case .headerProminence(let value): return AnyView(content.environment(\.headerProminence, value))
      case .horizontalSizeClass(let value): return AnyView(content.environment(\.horizontalSizeClass, value))
      case .isEnabled(let value): return AnyView(content.environment(\.isEnabled, value))
      case .imageScale(let value): return AnyView(content.environment(\.imageScale, value))
      case .isScrollEnabled(let value): return AnyView(content.environment(\.isScrollEnabled, value))
      case .isLuminanceReduced(let value): return AnyView(content.environment(\.isLuminanceReduced, value))
      case .locale(let value): return AnyView(content.environment(\.locale, value))
      case .lineLimit(let value): return AnyView(content.environment(\.lineLimit, value))
      case .lineSpacing(let value): return AnyView(content.environment(\.lineSpacing, value))
      case .layoutDirection(let value): return AnyView(content.environment(\.layoutDirection, value))
      case .legibilityWeight(let value): return AnyView(content.environment(\.legibilityWeight, value))
      case .menuOrder(let value): return AnyView(content.environment(\.menuOrder, value))
      case .minimumScaleFactor(let value): return AnyView(content.environment(\.minimumScaleFactor, value))
      case .managedObjectContext(let value): return AnyView(content.environment(\.managedObjectContext, value))
      case .multilineTextAlignment(let value): return AnyView(content.environment(\.multilineTextAlignment, value))
      case .menuIndicatorVisibility(let value): return AnyView(content.environment(\.menuIndicatorVisibility, value))
      case .openURL(let value): return AnyView(content.environment(\.openURL, value))
      case .redactionReasons(let value): return AnyView(content.environment(\.redactionReasons, value))
      case .scenePhase(let value): return AnyView(content.environment(\.scenePhase, value))
      case .symbolVariants(let value): return AnyView(content.environment(\.symbolVariants, value))
      case .symbolRenderingMode(let value): return AnyView(content.environment(\.symbolRenderingMode, value))
      case .scrollDismissesKeyboardMode(let value): return AnyView(content.environment(\.scrollDismissesKeyboardMode, value))
      case .textCase(let value): return AnyView(content.environment(\.textCase, value))
      case .timeZone(let value): return AnyView(content.environment(\.timeZone, value))
      case .truncationMode(let value): return AnyView(content.environment(\.truncationMode, value))
      case .verticalSizeClass(let value): return AnyView(content.environment(\.verticalSizeClass, value))
      case .horizontalScrollBounceBehavior(let value): return AnyView(content.environment(\.horizontalScrollBounceBehavior, value))
      case .verticalScrollBounceBehavior(let value): return AnyView(content.environment(\.verticalScrollBounceBehavior, value))
    }
  }
  
  /// This is used to set the title of the preview
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
