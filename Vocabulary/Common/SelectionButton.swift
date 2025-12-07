import SwiftUI

// MARK: - Reusable Selection Button
extension UI.SharedComponents {
  struct SelectionButton: View {
    // MARK: - Properties
    let leadingContent: LeadingContent
    let title: String
    let subtitle: String
    let isSelected: Bool
    let action: Action
    
    // MARK: - Body
    var body: some View {
      
      SwiftUI.Button(action: action) {
        HStack(spacing: VocabSpacing.spacing2) {
          // Leading content (emoji or icon)
          makeLeadingContent()
          
          // Text content
          VStack(alignment: .leading, spacing: VocabSpacing.spacing0_5) {
            Text(title)
              .font(VocabTypography.bodyBold)
              .foregroundColor(isSelected ? .white : .vocabTextPrimary)
            
            Text(subtitle)
              .font(VocabTypography.caption)
              .foregroundColor(isSelected ? .white.opacity(0.9) : .vocabTextSecondary)
          }
          
          Spacer()
          
          // Checkmark indicator
          Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
            .font(.title3)
            .foregroundColor(isSelected ? .white : .vocabTextLight)
        }
        .padding(VocabSpacing.spacing2)
        .frame(maxWidth: .infinity)
        .background(isSelected ? Color.vocabPrimary : Color.vocabCardBackground)
        .cornerRadius(VocabRadius.medium)
        .shadow(
          color: isSelected ? Color.vocabPrimary.opacity(0.3) : VocabShadow.small.color,
          radius: isSelected ? 8 : VocabShadow.small.radius,
          x: 0,
          y: isSelected ? 6 : VocabShadow.small.y
        )
      }
      .buttonStyle(.plain)
    }
    
    // MARK: - Private Views
    @ViewBuilder
    private func makeLeadingContent() -> some View {
      switch leadingContent {
      case .emoji(let emoji):
        Text(emoji)
          .font(.system(size: 40))
      case .icon(let systemName):
        Image(systemName: systemName)
          .font(.system(size: 32))
          .foregroundColor(isSelected ? .white : .vocabPrimary)
      }
    }
  }
}

// MARK: - Leading Content Type
extension UI.SharedComponents.SelectionButton {
  enum LeadingContent {
    case emoji(String)
    case icon(String)
  }
}

// MARK: - Convenience Initializers
extension UI.SharedComponents.SelectionButton {
  /// Creates a selection button with an emoji
  init(
    emoji: String,
    title: String,
    subtitle: String,
    isSelected: Bool,
    action: @escaping Action
  ) {
    self.leadingContent = .emoji(emoji)
    self.title = title
    self.subtitle = subtitle
    self.isSelected = isSelected
    self.action = action
  }
  
  /// Creates a selection button with an SF Symbol icon
  init(
    icon: String,
    title: String,
    subtitle: String,
    isSelected: Bool,
    action: @escaping Action
  ) {
    self.leadingContent = .icon(icon)
    self.title = title
    self.subtitle = subtitle
    self.isSelected = isSelected
    self.action = action
  }
}

