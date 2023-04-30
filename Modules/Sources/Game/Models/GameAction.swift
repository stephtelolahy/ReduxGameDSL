//
//  GameAction.swift
//  
//
//  Created by Hugues Telolahy on 06/04/2023.
//

/// Game action
/// Triggered by user or by the system, that causes any update to the game state
public indirect enum GameAction: Codable, Equatable {
    
    /// Play a hand card
    case play(actor: String, card: String, target: String? = nil)

    /// Process queued effects
    case update

    /// Apply effect
    case effect(CardEffect, ctx: EffectContext?)

    /// Ask a player to choose an action
    // TODO: remove because this does not cause any change to the game state
    case chooseOne(chooser: String, options: [String: GameAction])
}
