import Foundation

// MARK: - UI.Navigation.Destination

extension UI.Navigation {
  enum Destination {
    case home
    case onboarding
    case getName
    case levels
    case learningCapacity
    case customization
    case achievement
  }
}

// MARK: - UI.Navigation.Destination + Equatable

extension UI.Navigation.Destination: Equatable {
  static func == (lhs: UI.Navigation.Destination, rhs: UI.Navigation.Destination) -> Bool {
    switch (lhs, rhs) {
    case (.home, .home): true
    case (.onboarding, .onboarding): true
    case (.getName, .getName): true
    case (.levels, .levels): true
    case (.learningCapacity, .learningCapacity): true
    case (.customization, .customization): true
    case (.achievement, .achievement): true
    case (.home, _),
      (.onboarding, _),
      (.getName, _),
      (.levels, _),
      (.learningCapacity, _),
      (.customization, _),
      (.achievement, _):
      false
    }
  }
}

// MARK: - UI.Navigation.Destination + Hashable, Identifiable

extension UI.Navigation.Destination: Hashable, Identifiable {
  var id: String {
    "\(self)"
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(hashValue)
  }
}
