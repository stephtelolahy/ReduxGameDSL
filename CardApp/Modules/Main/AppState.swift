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
//        screens = screens.map {
//            switch $0 {
//            case .splashScreen: return .splashScreen
//            case .home(let state): return .home(HomeState.reducer(state, action))
//            case .episode(let state): return .episode(EpisodeDetailsState.reducer(state, action))
//            case .userProfile(let state): return .userProfile(UserDetailsState.reducer(state, action))
//            }
//        }

        return .init(screens: screens)
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
