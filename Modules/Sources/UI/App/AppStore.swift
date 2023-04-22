//
//  AppStore.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

import Redux

func createAppStore(initial: AppState) -> Store<AppState, Action> {
    Store(initial: initial,
          reducer: AppState.reducer,
          middlewares: [])
}
