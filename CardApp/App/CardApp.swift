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
        let store = CardAppStore.create()
        return WindowGroup {
            AppView()
                .tint(.yellow)
                .accentColor(.yellow)
                .foregroundColor(.primary)
                .environmentObject(store)
        }
    }
}
