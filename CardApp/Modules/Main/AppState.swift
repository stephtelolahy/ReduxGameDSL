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
        var screens = state.screens

        // Update visible screens
        switch action {
        case .showScreen(.splash),
             .dismissScreen(.home),
             .dismissScreen(.splash):
            screens = [.splash]

        case .showScreen(.home):
            screens = [.home(.init())]

        default:
            break
        }

        // Reduce each screen state
        screens = screens.map { reduceScreenState($0, action) }

        return .init(screens: screens)
    }

    private static func reduceScreenState(_ state: ScreenState, _ action: AppAction) -> ScreenState {
        switch state {
        case .splash:
            return .splash

        case .home(let state):
            return .home(HomeState.reducer(state, action))

        default:
            return state
        }
    }
}

extension AppState {
    func screenState<State>(for screen: AppScreen) -> State? {
        screens
            .compactMap {
                switch ($0, screen) {
                case (.home(let state), .home): return state as? State
                default: return nil
                }
            }
            .first
    }
}
