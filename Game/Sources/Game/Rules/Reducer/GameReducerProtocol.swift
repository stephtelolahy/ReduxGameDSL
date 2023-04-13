//
//  GameReducerProtocol.swift
//  
//
//  Created by Hugues Telolahy on 13/04/2023.
//

/// A protocol that describes how to evolve the current game state
/// Throwing Error
protocol GameReducerProtocol {

    /// Evolves the current state of the reducer to the next state.
    func reduce(state: GameState, action: GameAction) throws -> GameState
}
