//
//  ContentView.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

import SwiftUI
import Redux

let store = Store<AppState, Action>(
    initial: AppState(screens: [.splash]),
    reducer: AppState.reducer,
    middlewares: [loggerMiddleware]
)

public struct ContentView: View {

    public init() {}

    public var body: some View {
        MainView()
            .foregroundColor(.primary)
            .environmentObject(store)
    }
}

struct MainView: View {

    @EnvironmentObject private var store: Store<AppState, Action>

    var body: some View {
        switch store.state.screens.last {
        case .home:
            HomeView()

        case .game:
            GamePlayView()

        default:
            SplashView()
        }
    }
}

#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(previewStore)
    }
}
#endif

#if DEBUG
let previewStore = Store<AppState, Action>(
    initial: AppState(screens: [.splash]),
    reducer: { state, _ in state },
    middlewares: []
)
#endif
