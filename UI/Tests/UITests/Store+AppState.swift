//
//  Store+AppState.swift
//  
//
//  Created by Hugues Telolahy on 08/04/2023.
//
@testable import UI
import Redux

func createAppStore(initial: AppState) -> Store<AppState, Action> {
    Store(initial: initial,
          reducer: AppState.reducer,
          middlewares: [])
}
