import Foundation
import SwiftUI
import Lottie

extension UI.Onboarding {
  struct View: Screen {
    @EnvironmentObject
    private var navigationManager: UI.Navigation.Manager
    
    var body: some Screen {
      NavigationStack(path: $navigationManager.path) {
        VStack(spacing: VocabSpacing.spacing2) {
          Spacer()
          makeLottieView()
          makeTextTitleView()
          Spacer()
          makeContiueButton()
        }
        .padding(VocabSpacing.spacing2)
        .background(Color.vocabBackground.ignoresSafeArea())
        .navigationDestination(for: UI.Navigation.Destination.self) { destination in
          UI.Navigation.ViewProvider(destination: destination)
        }
      }
    }
    
    private func makeLottieView() -> some Screen {
      LottieView(animation: .named(.knowledgeIcon))
        .playing(loopMode: .autoReverse)
        .frame(width: 200, height: 200)
    }
    
    private func makeTextTitleView() -> some Screen {
      VStack(alignment: .center, spacing: VocabSpacing.spacing1) {
        Text("Expand Your Vocabulary\nin 1 minute a day")
          .font(VocabTypography.title1)
          .fontWeight(.bold)
          .foregroundColor(.vocabTextPrimary)
          
        Text("Learn 10,000+ words with a new daily habit that takes just 1 minute.")
          .font(VocabTypography.body)
          .foregroundColor(.vocabTextSecondary)
      }
      .multilineTextAlignment(.center)
      .padding(.horizontal, VocabSpacing.spacing2)
    }
    
    private func makeContiueButton() -> some Screen {
      Button("Continue") {
        navigationManager.push(.getName)
      }
      .buttonStyle(UI.SharedComponents.Button.primary)
      .padding(VocabSpacing.spacing2)
    }
  }
}

#Preview(body: {
  UI.Onboarding.View()
})
