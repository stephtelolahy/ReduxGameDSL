import Foundation
import Redux

struct AppState: Codable, Equatable {
    let screens: [ScreenState]

    init(screens: [ScreenState]) {
        self.screens = screens
    }
}

enum ScreenState: Codable, Equatable {
    case splash
    case home(Home.State)
    case game(GamePlayState)
}

enum Action: Codable, Equatable {
    case showScreen(Screen)
    case dismissScreen(Screen)
    case home(Home.Action)
    case game(GamePlayAction)
}

enum Screen: Codable, Equatable {
    case splash
    case home
    case game
}

extension AppState {
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

        case let (.game(gameState), _):
            return .game(GamePlayState.reducer(gameState, action))

        default:
            return state
        }
    }
}
