import SwiftUI

extension UI.Home {
  struct View: Screen {
    // MARK: - Properties
    @StateObject private var viewModel = ViewModel()
    
    // MARK: - Body
    var body: some Screen {
      ZStack(alignment: .top) {
        Color.vocabBackground
          .ignoresSafeArea()
        
        GeometryReader { geometry in
          ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 0) {
              makeWelcomePage()
                .frame(height: geometry.size.height)
                .id(0)
                .onAppear {
                  viewModel.updatePageNumber(0)
                }
              
              ForEach(Array(viewModel.vocabularyWords.enumerated()), id: \.element.id) { index, word in
                VocabularyCard(word: word)
                  .frame(height: geometry.size.height)
                  .id(index + 1)
                  .onAppear {
                    viewModel.updatePageNumber(index + 1)
                  }
              }
              
              makeContentPage()
                .frame(height: geometry.size.height)
                .id(viewModel.vocabularyWords.count + 1)
                .onAppear {
                  viewModel.updatePageNumber(viewModel.vocabularyWords.count + 1)
                }
            }
          }
          .scrollTargetBehavior(.paging)
          
        }
        
        // Progress bar in header
        DailyProgressBar(
          wordsLearned: $viewModel.wordsLearnedToday,
          dailyGoal: viewModel.dailyGoal
        )
      }
      .ignoresSafeArea()
      .navigationBarHidden(true)
    }
    
    // MARK: - Views
    private func makeWelcomePage() -> some Screen {
      VStack(spacing: 0) {
        Spacer()
        
        VStack(spacing: VocabSpacing.spacing2) {
          Text("📚")
            .font(.system(size: 80))
          
          Text("Welcome To\nVocabulary")
            .font(VocabTypography.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.vocabTextPrimary)
          
          Text("Your journey to 10,000 words starts here")
            .font(VocabTypography.body)
            .foregroundColor(.vocabTextSecondary)
        }
        .multilineTextAlignment(.center)
        
        Spacer()
        
        SwipeUpIndicator()
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .padding(VocabSpacing.spacing2)
    }
    
    private func makeContentPage() -> some Screen {
      VStack(spacing: VocabSpacing.spacing3) {
        Spacer()
        
        Image(systemName: "checkmark.circle.fill")
          .font(.system(size: 100))
          .foregroundColor(.vocabSuccess)
        
        Text("Goal Complete! 🎉")
          .font(VocabTypography.largeTitle)
          .fontWeight(.bold)
          .foregroundColor(.vocabTextPrimary)
          .multilineTextAlignment(.center)
        
        Text("You've completed all the steps!")
          .font(VocabTypography.body)
          .foregroundColor(.vocabTextSecondary)
          .multilineTextAlignment(.center)
        
        Spacer()
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .padding(VocabSpacing.spacing2)
    }
    
  }
}

// MARK: - Preview
#Preview {
  UI.Home.View()
}

