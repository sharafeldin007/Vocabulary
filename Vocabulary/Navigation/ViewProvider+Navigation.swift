import SwiftUI

extension UI.Navigation {
  @available(iOS 16.0, *)
  struct ViewProvider: Screen {
    let destination: UI.Navigation.Destination
    var body: some Screen {
      switch destination {
      case .onboarding:
        UI.Onboarding.View()
      case .home:
        Text("Home Screen")
          .font(.largeTitle)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .background(Color.green.opacity(0.2))
      case .getName:
        UI.Onboarding.GetName.View()
      case .levels:
        UI.Onboarding.Levels.View()
      case .learningCapacity:
        UI.Onboarding.LearningCapacity.View()
      case .customization:
        UI.Onboarding.Customization.View()
      case .achievement:
        UI.Onboarding.Achievement.View()
      }
    }
  }
}
