//
//  CardApp.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

import SwiftUI

@main
struct CardApp: App {
    var body: some Scene {
        let store = CardAppStore(
            initial: AppState(screens: [.splash]),
            reducer: AppState.reducer,
            middlewares: [])

        return WindowGroup {
            MainView()
                .tint(.yellow)
                .foregroundColor(.primary)
                .environmentObject(store)
        }
    }
}
