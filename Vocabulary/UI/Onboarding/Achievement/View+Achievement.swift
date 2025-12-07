import SwiftUI

extension UI.Onboarding.Achievement {
  struct View: Screen {
    // MARK: - Properties
    @StateObject private var viewModel = ViewModel()
    @EnvironmentObject private var navigationManager: UI.Navigation.Manager
    
    // MARK: - Body
    var body: some Screen {
      ZStack {
        // Background
        Color.vocabBackground
          .ignoresSafeArea()
        
        // Confetti overlay
        if viewModel.showConfetti {
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
        viewModel.animateEntrance()
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
          .scaleEffect(viewModel.scaleAmount)
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
          value: viewModel.wordsPerWeek,
          label: "Words/Week",
          color: .vocabPrimary
        )
        
        StatCard(
          icon: "chart.line.uptrend.xyaxis",
          value: viewModel.userLevel,
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
      viewModel.handleComplete {
        navigationManager.push(.home)
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

