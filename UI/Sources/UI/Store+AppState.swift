//
//  Store+AppState.swift
//  
//
//  Created by Hugues Telolahy on 08/04/2023.
//
import Redux

func createAppStore(initial: AppState) -> Store<AppState, Action> {
    Store(initial: initial,
          reducer: AppState.reducer,
          middlewares: [])
}
