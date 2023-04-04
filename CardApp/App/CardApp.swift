//
//  CardApp.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

import SwiftUI

typealias AppStore = Store<AppState, AppAction>

let store = AppStore(
    initial: AppState(screens: [.splash]),
    reducer: AppState.reducer,
    middlewares: [LoggerMiddleware().middleware])

@main
struct CardApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .foregroundColor(.primary)
                .environmentObject(store)
        }
    }
}

#if DEBUG
extension AppStore {
    static let preview = AppStore(initial: AppState(screens: [.splash]),
                                  reducer: { state, _ in state },
                                  middlewares: [])
}
#endif
