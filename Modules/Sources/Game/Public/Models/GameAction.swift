//
//  GameAction.swift
//  
//
//  Created by Hugues Telolahy on 06/04/2023.
//

/// Game action
/// Triggered by user or by the system, that causes any update to the game state
public indirect enum GameAction: Codable, Equatable {
    
    // MARK: - Play
    
    /// Resolve a play
    case play(actor: String, card: String)
    
    /// Play a brown card, discard immediately
    case playImmediate(actor: String, card: String, target: String? = nil)

    /// Invoke  an ability
    case playAbility(actor: String, card: String)

    /// Play an equipment card
    case playEquipment(actor: String, card: String)

    /// Play an handicap card
    case playHandicap(actor: String, card: String, target: String)

    // MARK: - Renderable actions
    
    /// Restore player's health, limited to maxHealth
    case heal(Int, player: String)

    /// Deals damage to a player, attempting to reduce its Health by the stated amount
    case damage(Int, player: String)

    /// Draw top deck card
    case draw(player: String)

    /// Discard a player's card
    case discard(String, player: String)

    /// Draw card from other player
    case steal(String, target: String, player: String)

    /// Draw some cards from arena
    case chooseCard(String, player: String)

    /// Draw a card from deck and put to arena
    case discover

    /// Set turn
    case setTurn(String)

    /// Eliminate
    case eliminate(player: String)

    /// Set player attribute
    case setAttribute(AttributeKey, value: Int, player: String)
    
    /// Increment player attribute
    case incAttribute(AttributeKey, value: Int, player: String)

    /// Draw a card from deck and put to discard
    case luck

    /// Cancel next queued effect
    case cancel

    /// Ask a choice
    case chooseOne(player: String, options: [String: Self])
    
    // MARK: - Invisible actions

    /// Resolve an effect
    case resolve(CardEffect, ctx: EffectContext)

    /// Dispatch actions sequentially
    case group([Self])
}
