import Foundation

public struct AppState: Codable {
    var game: GameState?

    public init() {}
}

public enum AppAction {
    case startGame
    case game(GameAction)
}

public extension AppState {
    static let reducer: Reducer<Self, AppAction> = { state, action in
            .init()
    }
}
