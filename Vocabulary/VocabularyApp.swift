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

    var body: some Scene {
        WindowGroup {
          UI.Onboarding.View()
            .environmentObject(navigationManager)
        }
    }
}
