//
//  GameAction.swift
//  
//
//  Created by Hugues Telolahy on 06/04/2023.
//

/// Game action
/// Triggered by user or by the system, that causes any update to the game state
public indirect enum GameAction: Codable, Equatable {
    
    /// Play an active card
    case play(actor: String, card: String, target: String? = nil)

    /// Trigger a card when some event occurred
    case forcePlay(actor: String, card: String)

    /// Apply an effect
    case effect(CardEffect, ctx: EffectContext)

    /// Dispatch actions sequentially
    case groupActions([Self])

    /// Restore player's health, limited to maxHealth
    case heal(Int, player: String)

    /// Deals damage to a player, attempting to reduce its Health by the stated amount
    case damage(Int, player: String)

    /// Discard a player's card
    case discard(player: String, card: String)
}
