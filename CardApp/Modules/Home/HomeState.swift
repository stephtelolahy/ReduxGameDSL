//
//  HomeState.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

import Foundation

struct HomeState: Codable {
}

enum HomeAction {
}

extension HomeState {
    static let reducer: Reducer<Self, AppAction> = { state, action in
        state
    }
}
