import SwiftUI

// MARK: - Animations
/// Predefined animation curves for consistent motion
struct VocabAnimation {
  static let quick = Animation.easeInOut(duration: 0.2)
  static let spring = Animation.spring(response: 0.4, dampingFraction: 0.7)
  static let bounce = Animation.spring(response: 0.3, dampingFraction: 0.6)
}

