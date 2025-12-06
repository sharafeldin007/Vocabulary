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
      VStack(spacing: 32) {
        Spacer()
        
        makeLottieView()
        makeQuestionView()
        makeOptionsView()
        
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
      LottieView(animation: .named(.bookIcon))
        .playing(loopMode: .loop)
        .frame(width: 150, height: 150)
    }
    
    private func makeQuestionView() -> some Screen {
      VStack(spacing: 12) {
        Text("How many words do you\nwant to learn per week?")
          .font(.title2)
          .fontWeight(.bold)
        
        Text("Choose a pace that works for you")
          .font(.subheadline)
          .foregroundColor(.secondary)
      }
      .multilineTextAlignment(.center)
    }
    
    private func makeOptionsView() -> some Screen {
      VStack(spacing: 16) {
        ForEach(viewModel.options) { option in
          CapacityButton(
            capacity: option,
            isSelected: viewModel.isSelected(option)
          ) {
            viewModel.selectCapacity(option)
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
      .disabled(!viewModel.isCapacitySelected)
      .opacity(viewModel.isCapacitySelected ? 1.0 : 0.5)
      .padding()
    }
    
    // MARK: - Actions
    private func handleContinue() {
      guard viewModel.saveCapacity() else {
        return
      }
      
      // Navigate to next screen
      // navigationManager.push(.nextDestination)
    }
  }
}

// MARK: - Capacity Button Component
extension UI.Onboarding.LearningCapacity {
  struct CapacityButton: Screen {
    // MARK: - Properties
    let capacity: ViewModel.WordsPerWeek
    let isSelected: Bool
    let action: Action
    
    // MARK: - Body
    var body: some Screen {
      Button(action: action) {
        HStack(spacing: 16) {
          Text(capacity.emoji)
            .font(.system(size: 40))
          
          VStack(alignment: .leading, spacing: 4) {
            Text(capacity.title)
              .font(.headline)
              .foregroundColor(isSelected ? .white : .primary)
            
            Text(capacity.subtitle)
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
  UI.Onboarding.LearningCapacity.View()
    .environmentObject(UI.Navigation.Manager())
}

