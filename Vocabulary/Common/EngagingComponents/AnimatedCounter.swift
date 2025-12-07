import SwiftUI

// MARK: - Animated Counter
/// Displays a number that animates from 0 to the target value
struct AnimatedCounter: View {
  let value: Int
  let duration: Double
  
  @State private var displayValue: Int = 0
  
  init(value: Int, duration: Double = 0.5) {
    self.value = value
    self.duration = duration
  }
  
  var body: some View {
    Text("\(displayValue)")
      .contentTransition(.numericText())
      .animation(VocabAnimation.spring, value: displayValue)
      .onAppear {
        animateCounter()
      }
      .onChange(of: value) { oldValue, newValue in
        animateCounter()
      }
  }
  
  private func animateCounter() {
    let steps = 20
    let increment = value / steps
    
    for i in 0...steps {
      DispatchQueue.main.asyncAfter(deadline: .now() + (duration / Double(steps)) * Double(i)) {
        if i == steps {
          displayValue = value
        } else {
          displayValue = increment * i
        }
      }
    }
  }
}

