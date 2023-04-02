//
//  AppView.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var store: CardAppStore

    var body: some View {
        switch store.state.screens.last {
        case .home:
            HomeView()

        case .game:
            GameView()

        default:
            SplashView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(CardAppStore.preview)
    }
}
