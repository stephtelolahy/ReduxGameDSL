//
//  ContentView.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

import SwiftUI
import Redux

private let store = Store<AppState, Action>(
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

#if DEBUG
let previewStore = Store<AppState, Action>(
    initial: AppState(screens: [.splash]),
    reducer: { state, _ in state },
    middlewares: []
)
#endif
