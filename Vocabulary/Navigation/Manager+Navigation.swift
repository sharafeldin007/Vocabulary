import SwiftUI

extension UI.Navigation {
  /// A navigation manager that tracks a stack of destinations for programmatic navigation.
  @MainActor
  final class Manager: ObservableObject {
    /// The current navigation path represented as a stack of destinations.
    @Published
    var path: [Destination] = []

    /// The path for full screen presentation
    @Published
    public var fullScreenPath: Destination?

    /// Creates a new instance of the navigation manager.
    init() {}

    /// Pushes a new destination onto the navigation stack.
    ///
    /// - Parameter destination: The destination to navigate to.
    func push(_ destination: Destination) {
      path.append(destination)
    }

    /// Pops the topmost destination off the navigation stack, if any.
    func pop() {
      if !path.isEmpty {
        path.removeLast()
      }
    }

    /// Clears the entire navigation stack, returning to the root.
    func popToRoot() {
      path.removeAll()
    }

    /// Add a new destination as fullscreen
    public func presentAsFullScreen(_ path: Destination) {
      fullScreenPath = path
    }
  }
}
