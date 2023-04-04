//
//  AppView.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var store: AppStore

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

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(AppStore.preview)
    }
}
#endif
