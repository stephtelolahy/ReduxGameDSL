//
//  AppStore.swift
//  CardApp
//
//  Created by Hugues Telolahy on 04/04/2023.
//

public typealias AppStore = Store<AppState, AppAction>

#if DEBUG
public extension AppStore {

    static func create(_ initial: AppState = AppState(screens: [.splash])) -> AppStore {
        AppStore(
            initial: initial,
            reducer: AppState.reducer,
            middlewares: [LoggerMiddleware().middleware])
    }

    static let preview = AppStore(initial: AppState(screens: [.splash]),
                                  reducer: { state, _ in state },
                                  middlewares: [])
}
#endif
