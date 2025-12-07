import SwiftUI

extension UI.Onboarding.Achievement {
  @MainActor
  final class ViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var showConfetti = false
    @Published var scaleAmount: CGFloat = 0.5
    
    // MARK: - Computed Properties
    var wordsPerWeek: Int {
      AppSettings.wordsPerWeek
    }
    
    var userLevel: Int {
      let level = AppSettings.userVocabularyLevel
      switch level {
      case "Beginner": return 1
      case "Intermediate": return 5
      case "Advanced": return 10
      default: return 1
      }
    }
    
    // MARK: - Public Methods
    
    /// Triggers the entrance animation for the achievement icon
    func animateEntrance() {
      withAnimation(VocabAnimation.bounce.delay(0.2)) {
        scaleAmount = 1.0
      }
    }
    
    /// Handles the completion action - shows confetti and marks onboarding complete
    /// - Returns: Callback to execute after delay (for navigation)
    func handleComplete(onCompletion: @escaping () -> Void) {
      // Trigger celebration
      withAnimation(VocabAnimation.spring) {
        showConfetti = true
      }
      
      // Mark onboarding as complete
      AppSettings.hasCompletedOnboarding = true
      
      // Navigate after delay
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        onCompletion()
      }
    }
  }
}

