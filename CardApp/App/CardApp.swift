//
//  CardApp.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

import SwiftUI

let store = CardAppStore(
    initial: AppState(screens: [.splash]),
    reducer: AppState.reducer,
    middlewares: [])

@main
struct CardApp: App {
    var body: some Scene {
        UINavigationBar.appearance().tintColor = .systemYellow
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = .systemYellow

        return WindowGroup {
            ContentView()
                .tint(.yellow)
                .foregroundColor(.primary)
                .environmentObject(store)
        }
    }
}
