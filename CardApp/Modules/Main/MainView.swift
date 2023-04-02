//
//  MainView.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var store: CardAppStore

    var body: some View {
        if store.state.screenState(for: .game(id: "")) != nil {
            NavigationView {
                GameView()
            }
            .navigationViewStyle(.stack)
        }
        else if store.state.screenState(for: .home) as HomeState? != nil {
            NavigationView {
                HomeView()
            }
            .navigationViewStyle(.stack)
        }
        else {
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
