//
//  CardEffect.swift
//  
//
//  Created by Hugues Telolahy on 06/04/2023.
//

/// Function defining card side effects
public indirect enum CardEffect: Codable, Equatable {

    /// Restore player's health, limited to maxHealth
    case heal(Int, player: PlayerArg)

    /// Deals damage to a player, attempting to reduce its Health by the stated amount
    case damage(Int, player: PlayerArg)

    /// Draw top deck card
    case draw(player: PlayerArg)

    /// Discard a player's card to discard pile
    /// Actor is the card chooser
    case discard(player: PlayerArg, card: CardArg)

    /// Draw card from other player
    case steal(player: PlayerArg, target: PlayerArg, card: CardArg)

    /// Draw some cards from choosable zone
    case chooseCard(player: PlayerArg, card: CardArg)

    /// Draw a card from discard and put to choosable
    case reveal

    /// Repeat an effect
    case replayEffect(NumArg, CardEffect)

    /// Dispatch effects sequentially
    case groupEffects([CardEffect])
}
