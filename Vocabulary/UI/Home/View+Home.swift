import SwiftUI

extension UI.Home {
  struct View: Screen {
    // MARK: - Properties
    @State private var arrowOffset: CGFloat = 0
    
    // MARK: - Body
      var body: some Screen {
      VStack {
        Spacer()
        
        makeWelcomeView()
        
        Spacer()
        
        makeScrollIndicator()
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color.vocabBackground.ignoresSafeArea())
      .navigationBarHidden(true)
    }
    
    // MARK: - Views
    private func makeWelcomeView() -> some Screen {
      VStack(spacing: VocabSpacing.spacing2) {
        Text("📚")
          .font(.system(size: 80))
        
        Text("Welcome To\nVocabulary")
          .font(VocabTypography.largeTitle)
          .fontWeight(.bold)
          .foregroundColor(.vocabTextPrimary)
          .multilineTextAlignment(.center)
        
        Text("Your journey to 10,000 words starts here")
          .font(VocabTypography.body)
          .foregroundColor(.vocabTextSecondary)
          .multilineTextAlignment(.center)
      }
    }
    
    private func makeScrollIndicator() -> some Screen {
      VStack(spacing: VocabSpacing.spacing1) {
        Text("Swipe up to continue")
          .font(VocabTypography.caption)
          .foregroundColor(.vocabTextSecondary)
        
        // Flowing swipe-up animation
        ZStack {
          ForEach(0..<3, id: \.self) { index in
            Image(systemName: "chevron.compact.up")
              .font(.system(size: 28, weight: .bold))
              .foregroundColor(.vocabPrimary)
              .opacity(max(0, 1.0 - (arrowOffset + CGFloat(index * 12)) / 40.0))
              .offset(y: CGFloat(index * 12) - arrowOffset)
          }
        }
        .frame(height: 60)
      }
      .padding(.bottom, VocabSpacing.spacing3)
      .onAppear {
        withAnimation(
          Animation.linear(duration: 1.2).repeatForever(autoreverses: false)
        ) {
          arrowOffset = 40
        }
      }
    }
  }
}

// MARK: - Preview
#Preview {
  UI.Home.View()
}

