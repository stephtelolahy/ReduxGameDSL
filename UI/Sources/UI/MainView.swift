//
//  MainView.swift
//  
//
//  Created by Hugues Telolahy on 08/04/2023.
//
import SwiftUI
import Redux

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
