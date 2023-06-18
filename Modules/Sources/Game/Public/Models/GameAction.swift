//
//  GameAction.swift
//  
//
//  Created by Hugues Telolahy on 06/04/2023.
//

/// Game action
/// Triggered by user or by the system, that causes any update to the game state
public indirect enum GameAction: Codable, Equatable {

    // MARK: - Renderable actions
    
    /// Play a brown card, discard immediately
    case playImmediate(actor: String, card: String, target: String? = nil)

    /// Invoke  an ability
    case playAbility(actor: String, card: String)

    /// Play an equipment card
    case playEquipment(actor: String, card: String)

    /// Play an handicap card
    case playHandicap(actor: String, card: String, target: String)

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
    case drawToArena

    /// Set turn
    case setTurn(String)

    /// Eliminate
    case eliminate(String)

    /// Ask a player to choose an action
    case chooseOne(chooser: String, options: [String: Self])
    
    /// Set player attribute
    case setAttribute(player: String, attribute: AttributeKey, value: Int)
    
    /// Increment player attribute
    case incAttribute(player: String, attribute: AttributeKey, value: Int)

    // MARK: - Invisible actions

    /// Resolve a play
    case play(actor: String, card: String)

    /// Resolve an effect
    case resolve(CardEffect, ctx: EffectContext)

    /// Dispatch actions sequentially
    case groupActions([Self])
}
