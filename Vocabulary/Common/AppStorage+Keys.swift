import Foundation
import SwiftUI

// MARK: - AppStorage Keys
extension String {
  static let userNameKey = "userName"
  static let userVocabularyLevelKey = "userVocabularyLevel"
  static let wordsPerWeekKey = "wordsPerWeek"
  static let hasCompletedOnboardingKey = "hasCompletedOnboarding"
}

// MARK: - App Settings Helper
struct AppSettings {
  @AppStorage(.userNameKey) static var userName: String = ""
  @AppStorage(.userVocabularyLevelKey) static var userVocabularyLevel: String = ""
  @AppStorage(.wordsPerWeekKey) static var wordsPerWeek: Int = 0
  @AppStorage(.hasCompletedOnboardingKey) static var hasCompletedOnboarding: Bool = false
}

