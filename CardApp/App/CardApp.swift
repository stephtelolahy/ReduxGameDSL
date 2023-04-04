//
//  CardApp.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

import SwiftUI

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
