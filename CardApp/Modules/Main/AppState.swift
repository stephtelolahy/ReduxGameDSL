import Foundation

struct AppState: Codable, Equatable {
    let screens: [ScreenState]
}

enum ScreenState: Codable, Equatable {
    case splash
    case home(HomeState)
    case game(GameState)
}

enum AppAction: Codable, Equatable {
    case showScreen(Screen)
    case dismissScreen(Screen)
    case home(HomeAction)
    case game(GameEvent)
}

enum Screen: Codable, Equatable {
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
        screens = screens.map { reduceScreen($0, action) }

        return .init(screens: screens)
    }

    private static func reduceScreen(_ state: ScreenState, _ action: AppAction) -> ScreenState {
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
