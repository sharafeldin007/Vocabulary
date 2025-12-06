import Foundation
import SwiftUI

extension UI.Onboarding.Levels {
  struct View: Screen {
    // MARK: - Properties
    @StateObject private var viewModel = ViewModel()
    @EnvironmentObject private var navigationManager: UI.Navigation.Manager
    
    // MARK: - Body
    var body: some Screen {
      VStack(spacing: 32) {
        Spacer()
        
        makeQuestionView()
        makeLevelsView()
        
        Spacer()
        
        makeContinueButton()
      }
      .padding()
      .navigationBarHidden(true)
      .background(Color.yellow.opacity(0.2))
      .ignoresSafeArea()
    }
    
    // MARK: - Views
    private func makeQuestionView() -> some Screen {
      VStack(spacing: 8) {
        Text("📚")
          .font(.system(size: 60))
        
        Text("What's your\nvocabulary level?")
          .font(.title2)
          .fontWeight(.bold)
        
        Text("This helps us personalize your learning")
          .font(.subheadline)
          .foregroundColor(.secondary)
      }
      .multilineTextAlignment(.center)
    }
    
    private func makeLevelsView() -> some Screen {
      VStack(spacing: 12) {
        ForEach(viewModel.levels) { level in
          LevelButton(
            level: level,
            isSelected: viewModel.isSelected(level)
          ) {
            viewModel.selectLevel(level)
          }
        }
      }
      .padding(.horizontal)
    }
    
    private func makeContinueButton() -> some Screen {
      Button("Continue") {
        handleContinue()
      }
      .buttonStyle(UI.SharedComponents.Button.primary)
      .disabled(!viewModel.isLevelSelected)
      .opacity(viewModel.isLevelSelected ? 1.0 : 0.5)
      .padding()
    }
    
    // MARK: - Actions
    private func handleContinue() {
      guard viewModel.saveLevel() else {
        return
      }
      navigationManager.push(.learningCapacity)
    }
  }
}


// MARK: - Level Button Component
extension UI.Onboarding.Levels {
  struct LevelButton: Screen {
    // MARK: - Properties
    let level: ViewModel.Level
    let isSelected: Bool
    let action: Action
    
    // MARK: - Body
    var body: some Screen {
      Button(action: action) {
        HStack(spacing: 16) {
          VStack(alignment: .leading, spacing: 4) {
            Text(level.title)
              .font(.headline)
              .foregroundColor(isSelected ? .white : .primary)
            
            Text(level.description)
              .font(.caption)
              .foregroundColor(isSelected ? .white.opacity(0.9) : .secondary)
          }
          
          Spacer()
          
          Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
            .font(.title3)
            .foregroundColor(isSelected ? .white : .gray)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(isSelected ? Color.blue : Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
      }
      .buttonStyle(.plain)
    }
  }
}

// MARK: - Preview
#Preview {
  UI.Onboarding.Levels.View()
    .environmentObject(UI.Navigation.Manager())
}
