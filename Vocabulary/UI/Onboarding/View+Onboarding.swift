import Foundation
import SwiftUI
import Lottie

extension UI.Onboarding {
  struct View: Screen {
    @EnvironmentObject
    private var navigationManager: UI.Navigation.Manager
    
    var body: some Screen {
      NavigationStack(path: $navigationManager.path) {
        VStack(spacing: 16) {
          Spacer()
          makeLottieView()
          makeTextTitleView()
          Spacer()
          makeContiueButton()
        }
        .background(Color.yellow.opacity(0.2))
        .navigationDestination(for: UI.Navigation.Destination.self) { destination in
          UI.Navigation.ViewProvider(destination: destination)
        }
      }
    }
    
    private func makeLottieView() -> some Screen {
      LottieView(animation: .named(.knowledgeIcon))
        .playing(loopMode: .autoReverse)
    }
    
    private func makeTextTitleView() -> some Screen {
      VStack(alignment: .center, spacing: 8) {
        Text("Expand Your Vocabulary \n in 1 minute a day")
          .font(.title3)
          .fontWeight(.heavy)
          
        Text("Learn 10,000+ words with a new daily hapit that takes just 1 minute.")
          .font(.body)
      }
      .multilineTextAlignment(.center)
    }
    
    private func makeContiueButton() -> some Screen {
      Button("Continue") {
        navigationManager.push(.getName)
      }
      .buttonStyle(
        UI.SharedComponents.Button.primary
      )
      .padding()
    }
  }
}

#Preview(body: {
  UI.Onboarding.View()
})
