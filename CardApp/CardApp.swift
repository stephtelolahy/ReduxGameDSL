//
//  CardApp.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

import SwiftUI
import UI

let store = Store<AppState, Action>(
    initial: AppState(screens: [.splash]),
    reducer: AppState.reducer,
    middlewares: [loggerMiddleware]
)

@main
struct CardApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .foregroundColor(.primary)
                .environmentObject(store)
        }
    }
}
