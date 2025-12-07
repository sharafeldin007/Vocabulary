import SwiftUI

extension UI.Onboarding.Achievement {
  struct View: Screen {
    // MARK: - Properties
    @EnvironmentObject private var navigationManager: UI.Navigation.Manager
    @State private var showConfetti = false
    @State private var scaleAmount: CGFloat = 0.5
    
    // MARK: - Body
    var body: some Screen {
      ZStack {
        // Background
        Color.vocabBackground
          .ignoresSafeArea()
        
        // Confetti overlay
        if showConfetti {
          ConfettiView()
        }
        
        // Main content
        VStack(spacing: VocabSpacing.spacing4) {
          Spacer()
          
          makeAchievementIcon()
          makeContentView()
          
          Spacer()
          
          makeCompleteButton()
        }
        .padding(VocabSpacing.spacing3)
      }
      .navigationBarHidden(true)
      .onAppear {
        animateEntrance()
      }
    }
    
    // MARK: - Views
    private func makeAchievementIcon() -> some Screen {
      ZStack {
        // Glow effect
        Circle()
          .fill(
            RadialGradient(
              colors: [Color.vocabSuccess.opacity(0.3), Color.clear],
              center: .center,
              startRadius: 0,
              endRadius: 100
            )
          )
          .frame(width: 200, height: 200)
        
        // Icon
        Image(systemName: "star.fill")
          .font(.system(size: 80))
          .foregroundColor(.vocabSuccess)
          .scaleEffect(scaleAmount)
      }
    }
    
    private func makeContentView() -> some Screen {
      VStack(spacing: VocabSpacing.spacing2) {
        Text("🎉 Congratulations! 🎉")
          .font(VocabTypography.largeTitle)
          .foregroundColor(.vocabTextPrimary)
          .multilineTextAlignment(.center)
        
        Text("You're all set to start your vocabulary journey!")
          .font(VocabTypography.body)
          .foregroundColor(.vocabTextSecondary)
          .multilineTextAlignment(.center)
        
        // Stats cards
        makeStatsView()
      }
    }
    
    private func makeStatsView() -> some Screen {
      HStack(spacing: VocabSpacing.spacing2) {
        StatCard(
          icon: "book.fill",
          value: AppSettings.wordsPerWeek,
          label: "Words/Week",
          color: .vocabPrimary
        )
        
        StatCard(
          icon: "chart.line.uptrend.xyaxis",
          value: getLevel(),
          label: "Level",
          color: .vocabSecondary
        )
      }
      .padding(.top, VocabSpacing.spacing2)
    }
    
    private func makeCompleteButton() -> some Screen {
      Button("Start Learning") {
        handleComplete()
      }
      .buttonStyle(UI.SharedComponents.Button.success)
      .scaleOnTap()
      .padding(VocabSpacing.spacing2)
    }
    
    // MARK: - Actions
    private func handleComplete() {
      // Trigger celebration
      withAnimation(VocabAnimation.spring) {
        showConfetti = true
      }
      
      // Mark onboarding as complete
      AppSettings.hasCompletedOnboarding = true
      
      // Navigate to home after delay
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        navigationManager.push(.home)
      }
    }
    
    private func animateEntrance() {
      withAnimation(VocabAnimation.bounce.delay(0.2)) {
        scaleAmount = 1.0
      }
    }
    
    private func getLevel() -> Int {
      let level = AppSettings.userVocabularyLevel
      switch level {
      case "Beginner": return 1
      case "Intermediate": return 5
      case "Advanced": return 10
      default: return 1
      }
    }
  }
}

// MARK: - Stat Card Component
extension UI.Onboarding.Achievement {
  struct StatCard: Screen {
    let icon: String
    let value: Int
    let label: String
    let color: Color
    
    var body: some Screen {
      VStack(spacing: VocabSpacing.spacing1) {
        Image(systemName: icon)
          .font(.title2)
          .foregroundColor(color)
        
        AnimatedCounter(value: value, duration: 1.0)
          .font(VocabTypography.title1)
          .foregroundColor(.vocabTextPrimary)
        
        Text(label)
          .font(VocabTypography.caption)
          .foregroundColor(.vocabTextSecondary)
      }
      .frame(maxWidth: .infinity)
      .padding(VocabSpacing.spacing2)
      .background(Color.vocabCardBackground)
      .cornerRadius(VocabRadius.medium)
      .shadow(
        color: VocabShadow.small.color,
        radius: VocabShadow.small.radius,
        x: 0,
        y: VocabShadow.small.y
      )
    }
  }
}
// MARK: - Preview
#Preview {
  UI.Onboarding.Achievement.View()
    .environmentObject(UI.Navigation.Manager())
}

