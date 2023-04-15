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

    /// Draw top deck card
    case draw(player: PlayerArg)

    /// Discard a player's card to discard pile
    /// Actor is the card chooser
    case discard(player: PlayerArg, card: CardArg)

    /// Draw card from other player
    case steal(player: PlayerArg, target: PlayerArg, card: CardArg)

    /// Repeat an effect
    case replayEffect(NumArg, CardEffect)

    /// Draw some cards from choosable zone
    case chooseCard(player: PlayerArg, card: CardArg)

    /// Draw a card from discard and put to choosable
    case reveal

    /// Dispatch effects sequentially
    case groupEffects([CardEffect])
}
