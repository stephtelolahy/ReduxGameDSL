import Foundation

struct AppState: Codable {
    let screens: [ScreenState]

    enum ScreenState: Codable {
        case splash
        case home(HomeState)
        case game(GameState)
    }
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
