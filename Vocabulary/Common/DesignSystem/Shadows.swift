import SwiftUI

// MARK: - Shadows
/// Shadow definitions for depth and elevation
struct VocabShadow {
  static let small = Shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
  
  struct Shadow {
    let color: Color
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat
  }
}

