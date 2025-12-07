import SwiftUI

extension UI.Home {
  struct VocabularyCard: Screen {
    // MARK: - Properties
    let word: ViewModel.VocabularyWord
    
    // MARK: - Body
    var body: some Screen {
      VStack(spacing: VocabSpacing.spacing3) {
        Spacer()
        
        // Vocabulary Card
        VStack(spacing: VocabSpacing.spacing3) {
          // Word Number Badge
          HStack {
            Text("Word \(word.number)")
              .font(VocabTypography.caption)
              .foregroundColor(.vocabTextSecondary)
            Spacer()
          }
          
          // Image/Icon
          ZStack {
            Circle()
              .fill(Color.vocabPrimary.opacity(0.1))
              .frame(width: 120, height: 120)
            
            Image(systemName: word.icon)
              .font(.system(size: 50))
              .foregroundColor(.vocabPrimary)
          }
          
          // Word & Pronunciation
          VStack(spacing: VocabSpacing.spacing0_5) {
            Text(word.word)
              .font(VocabTypography.largeTitle)
              .fontWeight(.bold)
              .foregroundColor(.vocabTextPrimary)
            
            Text("/\(word.pronunciation)/")
              .font(VocabTypography.caption)
              .foregroundColor(.vocabTextSecondary)
              .italic()
          }
          
          // Definition Card
          VStack(alignment: .leading, spacing: VocabSpacing.spacing1) {
            HStack {
              Image(systemName: "text.book.closed.fill")
                .foregroundColor(.vocabPrimary)
                .font(.system(size: 14))
              Text("Definition")
                .font(VocabTypography.caption)
                .fontWeight(.semibold)
                .foregroundColor(.vocabTextSecondary)
            }
            
            Text(word.definition)
              .font(VocabTypography.body)
              .foregroundColor(.vocabTextPrimary)
              .multilineTextAlignment(.leading)
              .fixedSize(horizontal: false, vertical: true)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(VocabSpacing.spacing2)
          .background(Color.vocabPrimary.opacity(0.05))
          .cornerRadius(VocabRadius.medium)
          
          // Example Card
          VStack(alignment: .leading, spacing: VocabSpacing.spacing1) {
            HStack {
              Image(systemName: "quote.bubble.fill")
                .foregroundColor(.vocabSuccess)
                .font(.system(size: 14))
              Text("Example")
                .font(VocabTypography.caption)
                .fontWeight(.semibold)
                .foregroundColor(.vocabTextSecondary)
            }
            
            Text("\"\(word.example)\"")
              .font(VocabTypography.body)
              .foregroundColor(.vocabTextPrimary)
              .multilineTextAlignment(.leading)
              .fixedSize(horizontal: false, vertical: true)
              .italic()
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(VocabSpacing.spacing2)
          .background(Color.vocabSuccess.opacity(0.05))
          .cornerRadius(VocabRadius.medium)
        }
        .padding(VocabSpacing.spacing3)
        .background(Color.white)
        .cornerRadius(VocabRadius.medium)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 4)
        
        Spacer()
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .padding(VocabSpacing.spacing2)
    }
  }
}

