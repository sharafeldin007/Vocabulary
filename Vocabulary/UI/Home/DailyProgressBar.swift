import SwiftUI

extension UI.Home {
  struct DailyProgressBar: Screen {
    // MARK: - Properties
    @Binding var wordsLearned: Int
    let dailyGoal: Int
    
    // MARK: - Body
    var body: some Screen {
      let clampedValue = min(max(wordsLearned, 0), dailyGoal)
      
      VStack(spacing: VocabSpacing.spacing1) {
        Text("Today: \(clampedValue)/\(dailyGoal) words")
          .font(VocabTypography.caption)
          .fontWeight(.semibold)
          .foregroundColor(.vocabTextPrimary)
        
        ProgressView(value: Double(clampedValue), total: Double(dailyGoal))
          .progressViewStyle(.linear)
          .tint(.vocabPrimary)
          .frame(width: 220)
          .scaleEffect(x: 1, y: 2.5, anchor: .center)
      }
      .padding(VocabSpacing.spacing2)
      .background(Color.vocabCardBackground.opacity(0.95))
      .cornerRadius(VocabRadius.medium)
      .shadow(
        color: VocabShadow.small.color,
        radius: VocabShadow.small.radius,
        x: 0,
        y: VocabShadow.small.y
      )
      .padding(.top, 60)
    }
  }
}

