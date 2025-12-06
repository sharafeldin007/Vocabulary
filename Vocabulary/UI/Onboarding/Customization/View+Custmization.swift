import Foundation
import SwiftUI
import Lottie

extension UI.Onboarding.Customization {
  struct View: Screen {
    // MARK: - Properties
    @EnvironmentObject private var navigationManager: UI.Navigation.Manager
    
    // MARK: - Body
    var body: some Screen {
      VStack(spacing: 32) {
        Spacer()
        
        makeLottieView()
        makeContentView()
        
        Spacer()
        
        makeContinueButton()
      }
      .padding()
      .navigationBarHidden(true)
      .background(Color.yellow.opacity(0.2))
      .ignoresSafeArea()
    }
    
    // MARK: - Views
    private func makeLottieView() -> some Screen {
      LottieView(animation: .named(.customizationIcon))
        .playing(loopMode: .loop)
        .frame(width: 200, height: 200)
    }
    
    private func makeContentView() -> some Screen {
      VStack(spacing: 16) {
        Text("⚙️")
          .font(.system(size: 60))
        
        Text("Customize Your\nLearning Experience")
          .font(.title2)
          .fontWeight(.bold)
        
        Text("Tailor your vocabulary journey to match your goals and preferences")
          .font(.body)
          .foregroundColor(.secondary)
          .padding(.horizontal)
      }
      .multilineTextAlignment(.center)
    }
    
    private func makeContinueButton() -> some Screen {
      Button("Get Started") {
        handleContinue()
      }
      .buttonStyle(UI.SharedComponents.Button.primary)
      .padding()
    }
    
    // MARK: - Actions
    private func handleContinue() {
      UserDefaults.hasCompletedOnboarding = true
      navigationManager.push(.levels)
    }
  }
}

// MARK: - Preview
#Preview {
  UI.Onboarding.Customization.View()
    .environmentObject(UI.Navigation.Manager())
}

