import Foundation
import SwiftUI

extension UI.Onboarding.Levels {
  @MainActor
  final class ViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var selectedLevel: Level?
    @Published var isLevelSelected: Bool = false
    
    // MARK: - Properties
    let levels: [Level] = [.beginner, .intermediate, .advanced]
    
    // MARK: - Private Properties
    @AppStorage(.userVocabularyLevelKey) private var storedLevel: String = ""
    
    // MARK: - Initialization
    init() {
      loadStoredLevel()
    }
    
    // MARK: - Public Methods
    
    /// Selects a level
    func selectLevel(_ level: Level) {
      selectedLevel = level
      isLevelSelected = true
    }
    
    /// Checks if a level is currently selected
    func isSelected(_ level: Level) -> Bool {
      return selectedLevel == level
    }
    
    /// Saves the selected level
    @discardableResult
    func saveLevel() -> Bool {
      guard let level = selectedLevel else {
        return false
      }
      
      storedLevel = level.rawValue
      return true
    }
    
    // MARK: - Private Methods
    
    private func loadStoredLevel() {
      if !storedLevel.isEmpty {
        selectedLevel = Level(rawValue: storedLevel)
        isLevelSelected = selectedLevel != nil
      }
    }
  }
}

extension UI.Onboarding.Levels.ViewModel {
  enum Level: String, CaseIterable {
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case advanced = "Advanced"
  }
}

extension UI.Onboarding.Levels.ViewModel.Level: Identifiable {
  var id: String {
    return rawValue
  }
  
  var title: String {
    return rawValue
  }
  
  var description: String {
    switch self {
    case .beginner:
      return "I'm just starting out"
    case .intermediate:
      return "I have a basic understanding"
    case .advanced:
      return "I want to master advanced vocabulary"
    }
  }
}
