import SwiftUI

extension UI.Onboarding.GetName {
  struct View: Screen {
    // MARK: - Properties
    @StateObject
    private var viewModel = ViewModel()
    @FocusState
    private var isTextFieldFocused: Bool
    @EnvironmentObject
    private var navigationManager: UI.Navigation.Manager
    
    // MARK: - Body
    var body: some Screen {
      VStack(spacing: 24) {
        Spacer()
        
        makeHeaderView()
        makeNameInputView()
        
        Spacer()
        
        makeContinueButton()
      }
      .padding()
      .navigationBarHidden(true)
      .background(Color.yellow.opacity(0.2))
      .ignoresSafeArea()
      .onAppear {
        viewModel.loadStoredName()
        isTextFieldFocused = true
      }
    }
    
    // MARK: - Views
    private func makeHeaderView() -> some Screen {
      VStack(spacing: 12) {
        Text("👋")
          .font(.system(size: 60))
        
        Text("What's your name?")
          .font(.title2)
          .fontWeight(.bold)
        
        Text("Let's personalize your experience")
          .font(.subheadline)
          .foregroundColor(.secondary)
      }
      .multilineTextAlignment(.center)
    }
    
    private func makeNameInputView() -> some Screen {
      VStack(alignment: .leading, spacing: 8) {
        TextField("Enter your name", text: $viewModel.name)
          .textFieldStyle(.plain)
          .font(.title3)
          .padding()
          .background(Color.white)
          .cornerRadius(12)
          .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
          .focused($isTextFieldFocused)
          .autocorrectionDisabled()
          .textInputAutocapitalization(.words)
        
        if let errorMessage = viewModel.errorMessage {
          Text(errorMessage)
            .font(.caption)
            .foregroundColor(.red)
            .padding(.leading, 4)
        }
      }
      .padding(.horizontal)
    }
    
    private func makeContinueButton() -> some Screen {
      Button("Continue") {
        handleContinue()
      }
      .buttonStyle(UI.SharedComponents.Button.primary)
      .disabled(!viewModel.isNameValid)
      .opacity(viewModel.isNameValid ? 1.0 : 0.5)
      .padding()
    }
    
    // MARK: - Actions
    private func handleContinue() {
      guard viewModel.saveName() else {
        return
      }
      
      navigationManager.push(.customization)
    }
  }
}

#Preview {
  UI.Onboarding.GetName.View()
    .environmentObject(UI.Navigation.Manager())
}
