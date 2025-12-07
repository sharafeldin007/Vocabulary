//
//  VocabularyApp.swift
//  Vocabulary
//
//  Created by Ahmed Sharaf on 06/12/2025.
//

import SwiftUI

@main
struct VocabularyApp: App {
  @StateObject var navigationManager = UI.Navigation.Manager()
  @AppStorage(.hasCompletedOnboardingKey) private var hasCompletedOnboarding: Bool = false

  var body: some Scene {
    WindowGroup {
      if hasCompletedOnboarding {
        // Show Home screen if onboarding is complete
        UI.Home.View()
          .environmentObject(navigationManager)
      } else {
        // Show Onboarding for first-time users
        UI.Onboarding.View()
          .environmentObject(navigationManager)
      }
    }
  }
}
