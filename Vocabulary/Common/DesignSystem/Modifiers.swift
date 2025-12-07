import SwiftUI

// MARK: - View Extensions for Design System
extension View {
  /// Adds scale effect when tapping
  func scaleOnTap() -> some View {
    self.modifier(ScaleOnTapModifier())
  }
}

// MARK: - Scale on Tap Modifier
/// Provides tactile feedback by scaling down slightly when pressed
struct ScaleOnTapModifier: ViewModifier {
  @State private var isPressed = false
  
  func body(content: Content) -> some View {
    content
      .scaleEffect(isPressed ? 0.95 : 1.0)
      .animation(VocabAnimation.quick, value: isPressed)
      .simultaneousGesture(
        DragGesture(minimumDistance: 0)
          .onChanged { _ in isPressed = true }
          .onEnded { _ in isPressed = false }
      )
  }
}

