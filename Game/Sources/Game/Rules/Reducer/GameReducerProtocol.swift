//
//  GameReducerProtocol.swift
//  
//
//  Created by Hugues Telolahy on 13/04/2023.
//

protocol GameReducerProtocol {

    /// Evolves the current state of the reducer to the next state.
    func reduce(state: GameState, action: GameAction) throws -> GameState
}
