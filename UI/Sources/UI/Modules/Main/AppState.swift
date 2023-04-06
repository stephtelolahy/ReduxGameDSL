import Foundation

public struct AppState: Codable, Equatable {
    let screens: [ScreenState]

    public init(screens: [ScreenState]) {
        self.screens = screens
    }
}

public enum ScreenState: Codable, Equatable {
    case splash
    case home(HomeState)
    case game(GameState)
}

public enum AppAction: Codable, Equatable {
    case showScreen(Screen)
    case dismissScreen(Screen)
    case home(HomeAction)
    case game(GameAction)
}

public enum Screen: Codable, Equatable {
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

    private static func reduceScreenState(_ state: ScreenState, _ action: AppAction) -> ScreenState {
        switch state {
        case let .home(homeState):
            return .home(HomeState.reducer(homeState, action))

        case let .game(gameState):
            return .game(GameState.reducer(gameState, action))

        default:
            return state
        }
    }
}
