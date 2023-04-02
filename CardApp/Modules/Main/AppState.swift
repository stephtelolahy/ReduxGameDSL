import Foundation

struct AppState: Codable {
    var game: GameState?

    init() {}
}

enum AppAction {
    case showScreen(AppScreen)
    case dismissScreen(AppScreen)
    case game(GameAction)
}

extension AppState {
    static let reducer: Reducer<Self, AppAction> = { state, action in
            .init()
    }
}
