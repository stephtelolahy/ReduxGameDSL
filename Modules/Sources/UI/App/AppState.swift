import Foundation
import Redux

public struct AppState: Codable, Equatable {
    let screens: [ScreenState]

    public init(screens: [ScreenState]) {
        self.screens = screens
    }
}

public enum ScreenState: Codable, Equatable {
    case splash
    case home(Home.State)
    case game(GamePlay.State)
}

public enum Action: Codable, Equatable {
    case showScreen(Screen)
    case dismissScreen(Screen)
    case home(Home.Action)
    case game(GamePlay.Action)
}

public enum Screen: Codable, Equatable {
    case splash
    case home
    case game
}

public extension AppState {
    static let reducer: Reducer<Self, Action> = { state, action in
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

    private static func reduceScreen(_ state: ScreenState, _ action: Action) -> ScreenState {
        switch (state, action) {

        case let (.home(homeState), .home(homeAction)):
            return .home(Home().reduce(state: homeState, action: homeAction))

        case let (.game(gameState), .game(gameAction)):
            return .game(GamePlay().reduce(state: gameState, action: gameAction))

        default:
            return state
        }
    }
}
