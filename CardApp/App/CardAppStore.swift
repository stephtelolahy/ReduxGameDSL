//
//  CardAppStore.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

typealias CardAppStore = Store<AppState, AppAction>

extension CardAppStore {
    static let preview = CardAppStore(
        initial: AppState(screens: [.splash]),
        reducer: AppState.reducer,
        middlewares: [])
}
