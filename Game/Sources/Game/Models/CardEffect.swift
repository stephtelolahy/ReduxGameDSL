//
//  CardEffect.swift
//  
//
//  Created by Hugues Telolahy on 06/04/2023.
//

/// Function defining card side effects
public indirect enum CardEffect: Codable, Equatable {

    /// Restore player's health, limited to maxHealth
    case heal(Int, player: ArgPlayer)

    /// Draw top deck card
    case drawDeck(player: ArgPlayer)

    /// Discard a player's card to discard pile
    /// Actor is the card chooser
    case discard(player: ArgPlayer, card: ArgCard)

    /// Repeat an effect
    case replayEffect(Int, CardEffect)
}
