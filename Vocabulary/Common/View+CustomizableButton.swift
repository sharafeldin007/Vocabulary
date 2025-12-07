import Foundation
import SwiftUI

extension UI.SharedComponents {
  struct Button: ButtonStyle {
    // MARK: - Properties
    var backgroundColor: Color = .blue
    var foregroundColor: Color = .white
    var padding: EdgeInsets = EdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24)
    var cornerRadius: CGFloat = 12
    var font: Font = .body.bold()
    var isFullWidth: Bool = false
    var borderColor: Color? = nil
    var borderWidth: CGFloat = 0
    var shadowColor: Color = .black.opacity(0.1)
    var shadowRadius: CGFloat = 4
    var scaleEffect: CGFloat = 0.95
    
    // MARK: - ButtonStyle Implementation
    func makeBody(configuration: Configuration) -> some View {
      configuration.label
        .font(font)
        .foregroundColor(foregroundColor)
        .padding(padding)
        .frame(maxWidth: isFullWidth ? .infinity : nil)
        .background(backgroundColor)
        .cornerRadius(cornerRadius)
        .overlay(
          RoundedRectangle(cornerRadius: cornerRadius)
            .stroke(borderColor ?? .clear, lineWidth: borderWidth)
        )
        .shadow(color: shadowColor, radius: shadowRadius, x: 0, y: 2)
        .scaleEffect(configuration.isPressed ? scaleEffect : 1.0)
        .opacity(configuration.isPressed ? 0.9 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
  }
}

// MARK: - Predefined Button Styles
extension UI.SharedComponents.Button {
  /// Primary button style with solid background
  static var primary: UI.SharedComponents.Button {
    UI.SharedComponents.Button(
      backgroundColor: .orange,
      foregroundColor: .white,
      cornerRadius: 12,
      font: .headline,
      isFullWidth: true
    )
  }
  
  /// Success button style for achievements
  static var success: UI.SharedComponents.Button {
    UI.SharedComponents.Button(
      backgroundColor: .green,
      foregroundColor: .white,
      cornerRadius: 12,
      font: .headline,
      isFullWidth: true
    )
  }
}
