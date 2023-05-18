//
//  CardEffect.swift
//  
//
//  Created by Hugues Telolahy on 30/04/2023.
//

public indirect enum CardEffect: Codable, Equatable {

    // MARK: - Actions

    /// Restore player's health, limited to maxHealth
    case heal(Int, player: PlayerArg)
    
    /// Deals damage to a player, attempting to reduce its Health by the stated amount
    case damage(Int, player: PlayerArg)
    
    /// Draw top deck card
    case draw
    
    /// Discard a player's card to discard pile
    /// Default chooser is player
    case discard(player: PlayerArg, card: CardArg, chooser: PlayerArg? = nil)
    
    /// Draw card from other player
    case steal(player: PlayerArg, target: PlayerArg, card: CardArg)
    
    /// Draw some cards from arena
    case chooseCard(player: PlayerArg, card: CardArg)
    
    /// Draw a card from deck and put to arena
    case reveal
    
    /// Set attribute turn
    case setTurn(PlayerArg)

    /// Eliminate a player from the game
    case eliminate(PlayerArg)

    // MARK: - Operators

    /// Repeat an effect
    case replayEffect(times: NumArg, effect: Self)
    
    /// Dispatch effects sequentially
    case groupEffects([Self])
    
    /// Apply an effect to some players
    case targetEffect(target: PlayerArg, effect: Self)

    /// Try an effect. If cannot, then apply some effect
    case forceEffect(effect: Self, otherwise: Self)

    /// Force two players to perform an effect repeatedly. If cannot, then apply some effect
    case challengeEffect(target: PlayerArg, challenger: PlayerArg, effect: Self, otherwise: Self)

    /// Requirements to validate an effect
    case requireEffect(playReqs: [PlayReq], effect: Self)
}
