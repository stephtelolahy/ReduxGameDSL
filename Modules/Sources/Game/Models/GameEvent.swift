//
//  GameEvent.swift
//  
//
//  Created by Hugues Telolahy on 29/04/2023.
//

/// Game events
/// Renderable events
public enum GameEvent: Codable, Equatable {

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

    /// Set turn
    case setTurn(String)

    /// Eliminate
    case eliminate(String)

    /// Ask a player to choose an action
    case chooseOne(chooser: String, options: Set<String>)
}
