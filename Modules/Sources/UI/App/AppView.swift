//
//  AppView.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

import SwiftUI
import Redux

public struct AppView: View {

    @EnvironmentObject private var store: Store<AppState, Action>

    public init() {}

    public var body: some View {
        Group {
            switch store.state.screens.last {
            case .home:
                HomeView()

            case .game:
                GamePlayView()

            default:
                SplashView()
            }
        }
        .foregroundColor(.primary)
    }
}

#if DEBUG
let previewStore = Store<AppState, Action>(
    initial: AppState(screens: [.splash]),
    reducer: { state, _ in state },
    middlewares: []
)

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
            .environmentObject(previewStore)
    }
}
#endif
