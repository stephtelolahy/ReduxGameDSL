//
//  HomeState.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

import Foundation
import Redux

public struct HomeState: Codable, Equatable {
}

public enum HomeAction: Codable, Equatable {
    case onAppear
}

extension HomeState {
    static let reducer: Reducer<Self, Action> = { state, _ in
        state
    }
}
