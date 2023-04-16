//
//  Home.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

import Redux

struct Home: ReducerProtocol {

    struct State: Codable, Equatable {
    }

    enum Action: Codable, Equatable {
        case onAppear
    }

    func reduce(state: State, action: Action) -> State {
        state
    }
}
