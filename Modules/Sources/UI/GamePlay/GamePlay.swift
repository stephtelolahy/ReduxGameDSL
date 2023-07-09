//
//  GamePlay.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//
import Redux
import Game

public struct GamePlay: ReducerProtocol {

    public struct State: Codable, Equatable {
        var game: GameState?
        var controlled: String?
        var message: String = String()

        // TODO: use single source of truth
        var players: [PlayerViewModel] = []
    }

    public enum Action: Codable, Equatable {
        case onAppear
    }

    public func reduce(state: State, action: Action) -> State {
        state
    }
}
