import SwiftUI

extension UI.Home {
  struct VocabularyCard: Screen {
    let word: UI.Home.ViewModel.VocabularyWord
    
    var body: some Screen {
      VStack(spacing: VocabSpacing.spacing3) {
        Spacer()
        
        VStack(spacing: VocabSpacing.spacing3) {
          wordBadge
          wordIcon
          wordHeader
          definitionSection
          exampleSection
        }
        .padding(VocabSpacing.spacing3)
        .background(Color.white)
        .cornerRadius(VocabRadius.large)
        .shadow(color: .black.opacity(0.1), radius: 10, y: 4)
        
        Spacer()
      }
      .padding(VocabSpacing.spacing2)
    }
  }
}

// MARK: - View Components

private extension UI.Home.VocabularyCard {
  var wordBadge: some View {
    HStack {
      Text("Word \(word.number)")
        .font(VocabTypography.caption)
        .foregroundColor(.vocabTextSecondary)
      Spacer()
    }
  }
  
  var wordIcon: some View {
    ZStack {
      Circle()
        .fill(Color.vocabPrimary.opacity(0.1))
        .frame(width: 120, height: 120)
      
      Image(systemName: word.icon)
        .font(.system(size: 50))
        .foregroundColor(.vocabPrimary)
    }
  }
  
  var wordHeader: some View {
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
  }
  
  var definitionSection: some View {
    InfoCard(
      icon: "text.book.closed.fill",
      title: "Definition",
      content: word.definition,
      tintColor: .vocabPrimary
    )
  }
  
  var exampleSection: some View {
    InfoCard(
      icon: "quote.bubble.fill",
      title: "Example",
      content: "\"\(word.example)\"",
      tintColor: .vocabSuccess,
      isItalic: true
    )
  }
}

// MARK: - InfoCard Component

private struct InfoCard: View {
  let icon: String
  let title: String
  let content: String
  let tintColor: Color
  var isItalic = false
  
  var body: some View {
    VStack(alignment: .leading, spacing: VocabSpacing.spacing1) {
      HStack {
        Image(systemName: icon)
          .font(.system(size: 14))
          .foregroundColor(tintColor)
        
        Text(title)
          .font(VocabTypography.caption)
          .fontWeight(.semibold)
          .foregroundColor(.vocabTextSecondary)
      }
      
      Text(content)
        .font(VocabTypography.body)
        .foregroundColor(.vocabTextPrimary)
        .italic(isItalic)
        .fixedSize(horizontal: false, vertical: true)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(VocabSpacing.spacing2)
    .background(tintColor.opacity(0.05))
    .cornerRadius(VocabRadius.medium)
  }
}
