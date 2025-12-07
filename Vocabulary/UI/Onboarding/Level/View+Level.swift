import Foundation
import SwiftUI

extension UI.Onboarding.Levels {
  struct View: Screen {
    // MARK: - Properties
    @StateObject private var viewModel = ViewModel()
    @EnvironmentObject private var navigationManager: UI.Navigation.Manager
    
    // MARK: - Body
    var body: some Screen {
      VStack(spacing: VocabSpacing.spacing4) {
        Spacer()
        
        makeQuestionView()
        makeLevelsView()
        
        Spacer()
        
        makeContinueButton()
      }
      .padding(VocabSpacing.spacing2)
      .navigationBarHidden(true)
      .background(Color.vocabBackground.ignoresSafeArea())
    }
    
    // MARK: - Views
    private func makeQuestionView() -> some Screen {
      VStack(spacing: VocabSpacing.spacing1) {
        Text("📚")
          .font(.system(size: 80))
        
        Text("What's your\nvocabulary level?")
          .font(VocabTypography.title1)
          .foregroundColor(.vocabTextPrimary)
          .multilineTextAlignment(.center)
        
        Text("This helps us personalize your learning")
          .font(VocabTypography.body)
          .foregroundColor(.vocabTextSecondary)
      }
      .multilineTextAlignment(.center)
    }
    
    private func makeLevelsView() -> some Screen {
      VStack(spacing: VocabSpacing.spacing2) {
        ForEach(viewModel.levels) { level in
          UI.SharedComponents.SelectionButton(
            icon: getLevelIcon(for: level),
            title: level.title,
            subtitle: level.description,
            isSelected: viewModel.isSelected(level)
          ) {
            withAnimation(VocabAnimation.spring) {
              viewModel.selectLevel(level)
            }
          }
        }
      }
      .padding(.horizontal, VocabSpacing.spacing2)
    }
    
    private func makeContinueButton() -> some Screen {
      Button("Continue") {
        handleContinue()
      }
      .buttonStyle(UI.SharedComponents.Button.primary)
      .disabled(!viewModel.isLevelSelected)
      .opacity(viewModel.isLevelSelected ? 1.0 : 0.5)
      .animation(VocabAnimation.quick, value: viewModel.isLevelSelected)
      .padding(VocabSpacing.spacing2)
    }
    
    // MARK: - Actions
    private func handleContinue() {
      guard viewModel.saveLevel() else {
        return
      }
      navigationManager.push(.learningCapacity)
    }
    
    // MARK: - Helper Methods
    private func getLevelIcon(for level: ViewModel.Level) -> String {
      switch level {
      case .beginner:
        return "book.fill"
      case .intermediate:
        return "books.vertical.fill"
      case .advanced:
        return "graduationcap.fill"
      }
    }
  }
}

// MARK: - Preview
#Preview {
  UI.Onboarding.Levels.View()
    .environmentObject(UI.Navigation.Manager())
}
