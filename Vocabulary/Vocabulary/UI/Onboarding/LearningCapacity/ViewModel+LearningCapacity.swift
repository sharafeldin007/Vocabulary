import Foundation
import SwiftUI

extension UI.Onboarding.LearningCapacity {
  @MainActor
  final class ViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var selectedCapacity: WordsPerWeek?
    @Published var isCapacitySelected: Bool = false
    
    // MARK: - Properties
    let options: [WordsPerWeek] = [.ten, .thirty, .fifty]
    @AppStorage(.wordsPerWeekKey) private var storedCapacity: Int = 0
    
    // MARK: - Initialization
    init() {
      loadStoredCapacity()
    }
    
    // MARK: - Public Methods
    
    /// Selects a learning capacity
    func selectCapacity(_ capacity: WordsPerWeek) {
      selectedCapacity = capacity
      isCapacitySelected = true
    }
    
    /// Checks if a capacity is currently selected
    func isSelected(_ capacity: WordsPerWeek) -> Bool {
      return selectedCapacity == capacity
    }
    
    /// Saves the selected capacity
    @discardableResult
    func saveCapacity() -> Bool {
      guard let capacity = selectedCapacity else {
        return false
      }
      
      storedCapacity = capacity.value
      return true
    }
    
    // MARK: - Private Methods
    
    private func loadStoredCapacity() {
      if storedCapacity > 0 {
        selectedCapacity = WordsPerWeek(rawValue: storedCapacity)
        isCapacitySelected = selectedCapacity != nil
      }
    }
  }
}

// MARK: - WordsPerWeek Enum
extension UI.Onboarding.LearningCapacity.ViewModel {
  enum WordsPerWeek: Int, CaseIterable {
    case ten = 10
    case thirty = 30
    case fifty = 50
  }
}

// MARK: - WordsPerWeek Extensions
extension UI.Onboarding.LearningCapacity.ViewModel.WordsPerWeek: Identifiable {
  var id: Int {
    return rawValue
  }
  
  var value: Int {
    return rawValue
  }
  
  var title: String {
    return "\(rawValue) words"
  }
  
  var subtitle: String {
    switch self {
    case .ten:
      return "Perfect for beginners"
    case .thirty:
      return "Steady progress"
    case .fifty:
      return "Ambitious learner"
    }
  }
  
  var emoji: String {
    switch self {
    case .ten:
      return "🐢"
    case .thirty:
      return "🚶"
    case .fifty:
      return "🚀"
    }
  }
}

