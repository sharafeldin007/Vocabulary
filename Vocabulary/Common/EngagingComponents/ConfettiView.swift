import SwiftUI

// MARK: - Celebration Confetti
/// Displays animated confetti falling from the top of the screen
struct ConfettiView: View {
  @State private var confettiPieces: [ConfettiPiece] = []
  
  var body: some View {
    ZStack {
      ForEach(confettiPieces) { piece in
        ConfettiShape(color: piece.color)
          .frame(width: piece.size, height: piece.size)
          .position(x: piece.x, y: piece.y)
          .opacity(piece.opacity)
      }
    }
    .onAppear {
      createConfetti()
    }
  }
  
  private func createConfetti() {
    let colors: [Color] = [.vocabPrimary, .vocabSecondary, .vocabAccent, .vocabSuccess]
    
    for i in 0..<50 {
      let piece = ConfettiPiece(
        id: i,
        x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
        y: -50,
        size: CGFloat.random(in: 8...15),
        color: colors.randomElement() ?? .vocabPrimary,
        opacity: 1.0
      )
      confettiPieces.append(piece)
      
      animateConfetti(index: i)
    }
  }
  
  private func animateConfetti(index: Int) {
    DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.01) {
      withAnimation(.linear(duration: Double.random(in: 2...4))) {
        confettiPieces[index].y = UIScreen.main.bounds.height + 50
        confettiPieces[index].opacity = 0
      }
    }
  }
  
  // MARK: - Supporting Types
  struct ConfettiPiece: Identifiable {
    let id: Int
    var x: CGFloat
    var y: CGFloat
    let size: CGFloat
    let color: Color
    var opacity: Double
  }
  
  struct ConfettiShape: View {
    let color: Color
    
    var body: some View {
      Circle()
        .fill(color)
    }
  }
}

