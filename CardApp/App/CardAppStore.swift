//
//  CardAppStore.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

typealias CardAppStore = Store<AppState, AppAction>

extension CardAppStore {
    
    static func create(initial: AppState = AppState(screens: [.splash])) -> CardAppStore {
        CardAppStore(
            initial: initial,
            reducer: AppState.reducer,
            middlewares: [])
    }
    
    static let preview = create()
}
