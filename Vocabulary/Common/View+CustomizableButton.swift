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
}

// MARK: - View Extension for Easy Usage
extension View {
  /// Apply a customizable button style
  func customButton(
    backgroundColor: Color = .blue,
    foregroundColor: Color = .white,
    padding: EdgeInsets = EdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24),
    cornerRadius: CGFloat = 12,
    font: Font = .body.bold(),
    isFullWidth: Bool = false,
    borderColor: Color? = nil,
    borderWidth: CGFloat = 0,
    shadowColor: Color = .black.opacity(0.1),
    shadowRadius: CGFloat = 4,
    scaleEffect: CGFloat = 0.95
  ) -> some View {
    self.buttonStyle(
      UI.SharedComponents.Button(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: padding,
        cornerRadius: cornerRadius,
        font: font,
        isFullWidth: isFullWidth,
        borderColor: borderColor,
        borderWidth: borderWidth,
        shadowColor: shadowColor,
        shadowRadius: shadowRadius,
        scaleEffect: scaleEffect
      )
    )
  }
}
