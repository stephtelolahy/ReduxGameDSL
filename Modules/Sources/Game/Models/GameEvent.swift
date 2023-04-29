//
//  GameEvent.swift
//  
//
//  Created by Hugues Telolahy on 29/04/2023.
//

/// Game events
public enum GameEvent: Codable, Equatable {

    /// play a hand card
    case play(actor: String, card: String, target: String? = nil)

    /// Restore player's health, limited to maxHealth
    case heal(Int, player: String)

    /// Deals damage to a player, attempting to reduce its Health by the stated amount
    case damage(Int, player: String)

    /// Draw top deck card
    case draw(player: String)

    /// Discard a player's card
    case discard(player: String, card: String)

    /// Draw card from other player
    case steal(player: String, target: String, card: String)

    /// Draw some cards from choosable zone
    case chooseCard(player: String, card: String)

    /// Draw a card from discard and put to choosable
    case reveal

    /// Ask a player to choose an action
    case chooseOne(chooser: String, choices: [String])
}
