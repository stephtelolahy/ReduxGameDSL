//
//  AppStore.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

typealias AppStore = Store<AppState, AppAction>

extension AppStore {
    
    static func create(initial: AppState = AppState(screens: [.splash])) -> AppStore {
        AppStore(
            initial: initial,
            reducer: AppState.reducer,
            middlewares: [EngineMiddleware().middleware,
                          LoggerMiddleware().middleware])
    }
    
    static let preview = create()
}
