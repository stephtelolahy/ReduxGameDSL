//
//  CardEffect.swift
//  
//
//  Created by Hugues Telolahy on 30/04/2023.
//

public indirect enum CardEffect: Codable, Equatable {
    /// Restore player's health, limited to maxHealth
    case heal(Int, player: PlayerArg)
    
    /// Deals damage to a player, attempting to reduce its Health by the stated amount
    case damage(Int, player: PlayerArg)
    
    /// Draw top deck card
    case draw(player: PlayerArg)
    
    /// Discard a player's card to discard pile
    /// Default chooser is player
    case discard(player: PlayerArg, card: CardArg, chooser: PlayerArg? = nil)
    
    /// Draw card from other player
    case steal(player: PlayerArg, target: PlayerArg, card: CardArg)
    
    /// Draw some cards from arena
    case chooseCard(player: PlayerArg, card: CardArg)
    
    /// Draw a card from deck and put to arena
    case reveal
    
    /// Challenging other player to force discard
    case challengeDiscard(player: PlayerArg, card: CardArg, otherwise: Self, challenger: PlayerArg)

    /// Set attribute turn
    case setTurn(PlayerArg)

    /// Eliminate a player from the game
    case eliminate(PlayerArg)

    /// Repeat an effect
    case replayEffect(times: NumArg, effect: Self)
    
    /// Dispatch effects sequentially
    case groupEffects([Self])
    
    /// Apply an effect to some players
    case applyEffect(target: PlayerGroupArg, effect: Self)

    /// Try an effect. If cannot, then apply some effect
    case forceEffect(effect: Self, otherwise: Self)
}
