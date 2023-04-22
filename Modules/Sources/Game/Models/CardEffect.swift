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
    /// The card chooser is current actor
    case discard(player: PlayerArg, card: CardArg)

    /// Draw card from other player
    case steal(player: PlayerArg, target: PlayerArg, card: CardArg)

    /// Draw some cards from choosable zone
    case chooseCard(player: PlayerArg, card: CardArg)

    /// Draw a card from discard and put to choosable
    case reveal

    /// Player must choose to discard one of his card.
    /// If cannot, then apply some effect
    case forceDiscard(player: PlayerArg, card: CardArg, otherwise: CardEffect)

    /// Repeat an effect
    case replayEffect(NumArg, CardEffect)

    /// Dispatch effects sequentially
    case groupEffects([CardEffect])

    /// Apply an effect to a group of players
    case applyEffect(PlayerArg, CardEffect)
}
