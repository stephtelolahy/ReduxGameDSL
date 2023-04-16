//
//  GamePlay.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//
import Redux
import Game

struct GamePlay: ReducerProtocol {

    struct State: Codable, Equatable {
        var game: GameState?
        var controlled: String?
        var message: String = String()
    }

    enum Action: Codable, Equatable {
        case onAppear
    }

    func reduce(state: State, action: Action) -> State {
        state
    }
}
