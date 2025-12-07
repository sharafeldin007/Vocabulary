import SwiftUI

extension UI.Home {
  struct SwipeUpIndicator: Screen {
    // MARK: - Properties
    @State private var arrowOffset: CGFloat = 0
    
    // MARK: - Body
    var body: some Screen {
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
        startAnimation()
      }
    }
    
    // MARK: - Helper Methods
    private func startAnimation() {
      withAnimation(
        Animation.linear(duration: 1.2).repeatForever(autoreverses: false)
      ) {
        arrowOffset = 30
      }
    }
  }
}

