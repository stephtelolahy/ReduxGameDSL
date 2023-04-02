import Foundation

struct AppState: Codable, Equatable {
    let screens: [AppScreenState]
}

enum AppScreenState: Codable, Equatable {
    case splash
    case home(HomeState)
    case game(GameState)
}

enum AppAction {
    case showScreen(AppScreen)
    case dismissScreen(AppScreen)
    case home(HomeAction)
    case game(GameAction)
}

enum AppScreen: Equatable {
    case splash
    case home
    case game
}

extension AppState {
    static let reducer: Reducer<Self, AppAction> = { state, action in
        var screens = state.screens

        // Update visible screens
        switch action {
        case .showScreen(.home),
             .dismissScreen(.game):
            screens = [.home(.init())]

        case .showScreen(.game):
            screens += [.game(.init())]

        default:
            break
        }

        // Reduce each screen state
        screens = screens.map { reduceScreenState($0, action) }

        return .init(screens: screens)
    }

    private static func reduceScreenState(_ state: AppScreenState, _ action: AppAction) -> AppScreenState {
        switch state {
        case let .home(homeState):
            guard case let .home(homeAction) = action else {
                return state
            }
            return .home(HomeState.reducer(homeState, homeAction))

        default:
            return state
        }
    }
}
