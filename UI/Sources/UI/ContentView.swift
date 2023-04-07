//
//  ContentView.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

import SwiftUI
import Redux

public struct ContentView: View {
    @EnvironmentObject private var store: Store<AppState, Action>

    public init() {}

    public var body: some View {
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
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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
