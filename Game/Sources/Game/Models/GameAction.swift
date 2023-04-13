//
//  GameAction.swift
//  
//
//  Created by Hugues Telolahy on 06/04/2023.
//

/// Function that causes any change in the game state
public enum GameAction: Codable, Equatable {
    
    /// play a hand card
    case play(actor: String, card: String, target: String?)

    /// apply a card side effect
    case apply(CardEffect, ctx: EffectContext)
    
    /// process queued event
    case update
}
