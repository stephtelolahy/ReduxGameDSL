import Foundation

struct AppState: Codable {
    let screens: [AppScreenState]
}

enum AppAction {
    case showScreen(AppScreen)
    case dismissScreen(AppScreen)
    case game(GameAction)
}

extension AppState {
    static let reducer: Reducer<Self, AppAction> = { state, action in
            state
    }
}
