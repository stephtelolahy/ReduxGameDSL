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

    /// Restore player's health, limited to maxHealth
    case heal(player: String, value: Int)

    /// Deals damage to a player, attempting to reduce its Health by the stated amount
    case damage(player: String, value: Int)

    /// Draw top deck card
    case draw(player: String)

    /// Discard a player's card
    case discard(player: String, card: String)

    /// Draw card from other player
    case steal(player: String, target: String, card: String)

    /// Draw some cards from arena
    case chooseCard(player: String, card: String)

    /// Draw a card from discard and put to arena
    case reveal

    // MARK: - Invisible actions

    /// Apply an effect
    case effect(CardEffect, ctx: EffectContext)

    /// Dispatch actions sequentially
    case groupActions([Self])
}
