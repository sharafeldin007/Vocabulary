import SwiftUI

extension UI.Onboarding.GetName {
  @MainActor
  final class ViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var name: String = "" {
      didSet {
        validateName()
      }
    }
    @Published var isNameValid: Bool = false
    @Published var errorMessage: String?
    @Published var isWaving = false
    
    // MARK: - Private Properties
    @AppStorage(.userNameKey) private var storedName: String = ""
    
    // MARK: - Constants
    private let minimumNameLength = 2
    
    // MARK: - Initialization
    init() {
      // Validate on init if needed
    }
    
    // MARK: - Public Methods
    
    /// Loads the stored name on view appear
    func loadStoredName() {
      name = storedName
    }
    
    /// Validates and saves the name
    /// - Returns: True if save was successful, false otherwise
    @discardableResult
    func saveName() -> Bool {
      let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
      
      guard isNameValid else {
        errorMessage = "Please enter a valid name"
        return false
      }
      
      storedName = trimmedName
      return true
    }
    
    /// Clears the current name input
    func clearName() {
      name = ""
    }
    
    // MARK: - Private Methods
    
    private func validateName() {
      let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
      
      // Check if name is valid
      if trimmedName.count >= minimumNameLength {
        isNameValid = true
        errorMessage = nil
      } else {
        isNameValid = false
        // Show error only if user has started typing
        if !trimmedName.isEmpty {
          errorMessage = "Please enter at least \(minimumNameLength) characters"
        } else {
          errorMessage = nil
        }
      }
    }
  }
}

