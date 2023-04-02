//
//  ContentView.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: CardAppStore

    var body: some View {
        if store.state.screenState(for: .home) as HomeState? != nil {
            NavigationView {
                HomeView()
            }
            .navigationViewStyle(.stack)
        } else {
            SplashView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CardAppStore.preview)
    }
}
