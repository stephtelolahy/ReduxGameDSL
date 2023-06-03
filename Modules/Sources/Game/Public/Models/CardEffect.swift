//
//  CardEffect.swift
//  
//
//  Created by Hugues Telolahy on 30/04/2023.
//

public indirect enum CardEffect: Codable, Equatable {

    // MARK: - Actions

    /// Restore player's health, limited to maxHealth
    case heal(Int)
    
    /// Deals damage to a player, attempting to reduce its Health by the stated amount
    case damage(Int)
    
    /// Draw top deck card
    case draw
    
    /// Discard a player's card to discard pile
    /// Default chooser is player
    case discard(CardArg, chooser: PlayerArg? = nil)
    
    /// Draw card from other player
    case steal(CardArg, stealer: PlayerArg)
    
    /// Draw some cards from arena
    case chooseCard
    
    /// Draw a card from deck and put to arena
    case drawToArena
    
    /// Set attribute turn
    case setTurn

    /// Eliminate a player from the game
    case eliminate

    // MARK: - Operators

    /// Repeat an effect
    case repeatEffect(times: NumArg, effect: Self)
    
    /// Dispatch effects sequentially
    case groupEffects([Self])
    
    /// Apply an effect to some players
    case targetEffect(target: PlayerArg, effect: Self)

    /// Try an effect. If cannot, then apply some effect
    case forceEffect(effect: Self, otherwise: Self)

    /// Force two players to perform an effect repeatedly. If cannot, then apply some effect
    case challengeEffect(challenger: PlayerArg, effect: Self, otherwise: Self)

    /// Requirements to validate an effect
    case requireEffect(playReqs: [PlayReq], effect: Self)
}