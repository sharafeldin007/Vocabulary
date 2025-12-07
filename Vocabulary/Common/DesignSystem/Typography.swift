import SwiftUI

// MARK: - Typography
/// Typography system with rounded fonts for modern appearance
struct VocabTypography {
  // MARK: - Headers
  static let largeTitle = Font.system(size: 34, weight: .bold, design: .rounded)
  static let title1 = Font.system(size: 28, weight: .bold, design: .rounded)
  static let title3 = Font.system(size: 20, weight: .semibold, design: .rounded)
  
  // MARK: - Body
  static let body = Font.system(size: 17, weight: .regular, design: .rounded)
  static let bodyBold = Font.system(size: 17, weight: .semibold, design: .rounded)
  
  // MARK: - Supporting
  static let caption = Font.system(size: 12, weight: .regular, design: .rounded)
}

