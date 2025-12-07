import Foundation
import SwiftUI
import Lottie

extension UI.Onboarding.Customization {
  struct View: Screen {
    // MARK: - Properties
    @EnvironmentObject private var navigationManager: UI.Navigation.Manager
    
    // MARK: - Body
    var body: some Screen {
      VStack(spacing: VocabSpacing.spacing4) {
        Spacer()
        
        makeLottieView()
        makeContentView()
        
        Spacer()
        
        makeContinueButton()
      }
      .padding(VocabSpacing.spacing2)
      .navigationBarHidden(true)
      .background(Color.vocabBackground.ignoresSafeArea())
    }
    
    // MARK: - Views
    private func makeLottieView() -> some Screen {
      LottieView(animation: .named(.customizationIcon))
        .playing(loopMode: .loop)
        .frame(width: 200, height: 200)
    }
    
    private func makeContentView() -> some Screen {
      VStack(spacing: VocabSpacing.spacing2) {
        Text("⚙️")
          .font(.system(size: 80))
        
        Text("Customize Your\nLearning Experience")
          .font(VocabTypography.title1)
          .fontWeight(.bold)
          .foregroundColor(.vocabTextPrimary)
        
        Text("Tailor your vocabulary journey to match your goals and preferences")
          .font(VocabTypography.body)
          .foregroundColor(.vocabTextSecondary)
          .padding(.horizontal, VocabSpacing.spacing2)
      }
      .multilineTextAlignment(.center)
    }
    
    private func makeContinueButton() -> some Screen {
      Button("Get Started") {
        handleContinue()
      }
      .buttonStyle(UI.SharedComponents.Button.primary)
      .padding(VocabSpacing.spacing2)
    }
    
    // MARK: - Actions
    private func handleContinue() {
//      AppSettings.hasCompletedOnboarding = true
      navigationManager.push(.levels)
    }
  }
}

// MARK: - Preview
#Preview {
  UI.Onboarding.Customization.View()
    .environmentObject(UI.Navigation.Manager())
}

