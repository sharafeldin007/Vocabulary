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
      VStack(spacing: VocabSpacing.spacing3) {
        Spacer()
        
        makeHeaderView()
        makeNameInputView()
        
        Spacer()
        
        makeContinueButton()
      }
      .padding(VocabSpacing.spacing2)
      .navigationBarHidden(true)
      .background(Color.vocabBackground.ignoresSafeArea())
      .onAppear {
        viewModel.loadStoredName()
        isTextFieldFocused = true
      }
    }
    
    // MARK: - Views
    private func makeHeaderView() -> some Screen {
      VStack(spacing: VocabSpacing.spacing1) {
        Text("👋")
          .font(.system(size: 80))
          .rotationEffect(.degrees(viewModel.isWaving ? 20 : -20))
          .animation(
            Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true),
            value: viewModel.isWaving
          )
          .onAppear {
            viewModel.isWaving = true
          }
        
        Text("What's your name?")
          .font(VocabTypography.title1)
          .fontWeight(.bold)
          .foregroundColor(.vocabTextPrimary)
        
        Text("Let's personalize your experience")
          .font(VocabTypography.body)
          .foregroundColor(.vocabTextSecondary)
      }
      .multilineTextAlignment(.center)
    }
    
    private func makeNameInputView() -> some Screen {
      VStack(alignment: .leading, spacing: VocabSpacing.spacing1) {
        TextField("Enter your name", text: $viewModel.name)
          .textFieldStyle(.plain)
          .font(VocabTypography.title3)
          .padding(VocabSpacing.spacing2)
          .background(Color.vocabCardBackground)
          .cornerRadius(VocabRadius.medium)
          .shadow(
            color: VocabShadow.small.color,
            radius: VocabShadow.small.radius,
            x: 0,
            y: VocabShadow.small.y
          )
          .focused($isTextFieldFocused)
          .autocorrectionDisabled()
          .textInputAutocapitalization(.words)
        
        if let errorMessage = viewModel.errorMessage {
          Text(errorMessage)
            .font(VocabTypography.caption)
            .foregroundColor(.vocabError)
            .padding(.leading, VocabSpacing.spacing0_5)
        }
      }
      .padding(.horizontal, VocabSpacing.spacing2)
    }
    
    private func makeContinueButton() -> some Screen {
      Button("Continue") {
        handleContinue()
      }
      .buttonStyle(UI.SharedComponents.Button.primary)
      .disabled(!viewModel.isNameValid)
      .opacity(viewModel.isNameValid ? 1.0 : 0.5)
      .padding(VocabSpacing.spacing2)
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
