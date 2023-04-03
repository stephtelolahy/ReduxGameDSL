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
        WindowGroup {
            MainView()
                .foregroundColor(.primary)
                .environmentObject(AppStore.create())
        }
    }
}
