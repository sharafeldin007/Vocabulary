import SwiftUI

extension UI.Home {
  @MainActor
  final class ViewModel: ObservableObject {
    @Published var wordsLearnedToday = 0
    
    let vocabularyWords = VocabularyWord.sampleWords
    
    var dailyGoal: Int {
      max(AppSettings.wordsPerWeek / 10, 5)
    }
    
    func updatePageNumber(_ page: Int) {
      let wordsPerPage = dailyGoal / vocabularyWords.count
      wordsLearnedToday = min(page * wordsPerPage, dailyGoal)
    }
  }
}

// MARK: - VocabularyWord Model
extension UI.Home.ViewModel {
  struct VocabularyWord: Identifiable {
    let id = UUID()
    let number: Int
    let word: String
    let definition: String
    let example: String
    let icon: String
    let pronunciation: String
  }
}

extension UI.Home.ViewModel.VocabularyWord {
  static let sampleWords: [UI.Home.ViewModel.VocabularyWord] = [
    .init(
      number: 1,
      word: "Serendipity",
      definition: "The occurrence of events by chance in a happy or beneficial way",
      example: "Finding this beautiful café was pure serendipity!",
      icon: "star.fill",
      pronunciation: "ser-ən-ˈdi-pə-tē"
    ),
    .init(
      number: 2,
      word: "Ephemeral",
      definition: "Lasting for a very short time; temporary",
      example: "The beauty of cherry blossoms is ephemeral, lasting only a few weeks.",
      icon: "leaf.fill",
      pronunciation: "i-ˈfe-mə-rəl"
    ),
    .init(
      number: 3,
      word: "Eloquent",
      definition: "Fluent or persuasive in speaking or writing",
      example: "Her eloquent speech moved everyone in the audience to tears.",
      icon: "quote.bubble.fill",
      pronunciation: "ˈe-lə-kwənt"
    ),
    .init(
      number: 4,
      word: "Resilient",
      definition: "Able to withstand or recover quickly from difficult conditions",
      example: "Despite many setbacks, she remained resilient and continued pursuing her dreams.",
      icon: "shield.fill",
      pronunciation: "ri-ˈzil-yənt"
    ),
    .init(
      number: 5,
      word: "Catalyst",
      definition: "A person or thing that precipitates an event or change",
      example: "The invention of the internet was a catalyst for the digital revolution.",
      icon: "bolt.fill",
      pronunciation: "ˈka-tə-ləst"
    )
  ]
}
