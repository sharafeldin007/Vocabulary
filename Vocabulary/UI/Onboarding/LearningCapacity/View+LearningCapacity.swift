import Foundation
import SwiftUI
import Lottie

extension UI.Onboarding.LearningCapacity {
  struct View: Screen {
    // MARK: - Properties
    @StateObject private var viewModel = ViewModel()
    @EnvironmentObject private var navigationManager: UI.Navigation.Manager
    
    // MARK: - Body
    var body: some Screen {
      VStack(spacing: VocabSpacing.spacing4) {
        Spacer()
        
        makeLottieView()
        makeQuestionView()
        makeOptionsView()
        
        Spacer()
        
        makeContinueButton()
      }
      .padding(VocabSpacing.spacing2)
      .navigationBarHidden(true)
      .background(Color.vocabBackground.ignoresSafeArea())
    }
    
    // MARK: - Views
    private func makeLottieView() -> some Screen {
      LottieView(animation: .named(.bookIcon))
        .playing(loopMode: .loop)
        .frame(width: 150, height: 150)
    }
    
    private func makeQuestionView() -> some Screen {
      VStack(spacing: VocabSpacing.spacing1) {
        Text("How many words do you \n want to learn per week?")
          .font(VocabTypography.title1)
          .foregroundColor(.vocabTextPrimary)
        
        Text("Choose a pace that works for you")
          .font(VocabTypography.body)
          .foregroundColor(.vocabTextSecondary)
      }
      .multilineTextAlignment(.center)
    }
    
    private func makeOptionsView() -> some Screen {
      VStack(spacing: VocabSpacing.spacing2) {
        ForEach(viewModel.options) { option in
          UI.SharedComponents.SelectionButton(
            emoji: option.emoji,
            title: option.title,
            subtitle: option.subtitle,
            isSelected: viewModel.isSelected(option)
          ) {
            viewModel.selectCapacity(option)
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
      .disabled(!viewModel.isCapacitySelected)
      .opacity(viewModel.isCapacitySelected ? 1.0 : 0.5)
      .padding(VocabSpacing.spacing2)
    }
    
    // MARK: - Actions
    private func handleContinue() {
      guard viewModel.saveCapacity() else {
        return
      }
      navigationManager.push(.achievement)
    }
  }
}

// MARK: - Preview
#Preview {
  UI.Onboarding.LearningCapacity.View()
    .environmentObject(UI.Navigation.Manager())
}


