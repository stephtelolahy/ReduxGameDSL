//
//  HomeState.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

import Foundation

struct HomeState: Codable, Equatable {
}

enum HomeAction: Codable, Equatable {
    case didAppear
}

extension HomeState {
    static let reducer: Reducer<Self, HomeAction> = { state, action in
        state
    }
}
