import SwiftUI

// MARK: - Color Palette
extension Color {
  // MARK: - Primary Colors
  static let vocabPrimary = Color(hex: "#FF6B35")      // Vibrant Orange
  static let vocabSecondary = Color(hex: "#4ECDC4")    // Turquoise
  static let vocabAccent = Color(hex: "#FFD23F")       // Bright Yellow
  
  // MARK: - Background Colors
  static let vocabBackground = Color(hex: "#F7F7F7")   // Light Gray
  static let vocabCardBackground = Color.white
  
  // MARK: - Text Colors
  static let vocabTextPrimary = Color(hex: "#2D3436")  // Dark Gray
  static let vocabTextSecondary = Color(hex: "#636E72") // Medium Gray
  static let vocabTextLight = Color(hex: "#B2BEC3")    // Light Gray
  
  // MARK: - Semantic Colors
  static let vocabSuccess = Color(hex: "#00B894")      // Green
  static let vocabError = Color(hex: "#FF7675")        // Red
  
  // MARK: - Helper initializer for hex colors
  init(hex: String) {
    let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
    var int: UInt64 = 0
    Scanner(string: hex).scanHexInt64(&int)
    let a, r, g, b: UInt64
    switch hex.count {
    case 3: // RGB (12-bit)
      (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
    case 6: // RGB (24-bit)
      (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
    case 8: // ARGB (32-bit)
      (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
    default:
      (a, r, g, b) = (255, 0, 0, 0)
    }
    self.init(
      .sRGB,
      red: Double(r) / 255,
      green: Double(g) / 255,
      blue: Double(b) / 255,
      opacity: Double(a) / 255
    )
  }
}

