import Foundation

struct AppState: Codable {
    let screens: [AppScreenState]
}

enum AppScreenState: Codable {
    case splash
    case home(HomeState)
    case game(GameState)
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

        case .showScreen(.game(id: let id)):
            screens += [.home(.init())]

        default:
            break
        }

        // Reduce each screen state
        screens = screens.map { reduceScreenState($0, action) }

        return .init(screens: screens)
    }

    private static func reduceScreenState(_ state: AppScreenState, _ action: AppAction) -> AppScreenState {
        switch state {
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
                case (.home(let state), .home):
                    return state as? State

                case (.game(let state), .game(id: let id)):
                    return state as? State

                default: return nil
                }
            }
            .first
    }
}
