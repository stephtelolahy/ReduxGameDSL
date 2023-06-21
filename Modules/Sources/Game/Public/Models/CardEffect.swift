//
//  CardEffect.swift
//  
//
//  Created by Hugues Telolahy on 30/04/2023.
//

/// Effect that can be applied to a player or a group of players
public indirect enum CardEffect: Codable, Equatable {

    // MARK: - Actions

    /// Restore player's health, limited to maxHealth
    case heal(Int)
    
    /// Deals damage to a player, attempting to reduce its Health by the stated amount
    case damage(Int)
    
    /// Draw top deck card
    case draw
    
    /// Discard a player's card to discard pile
    /// When chooser is the player that chooses card
    /// By default `ctx.target`
    case discard(CardArg, chooser: PlayerArg? = nil)
    
    /// Draw card from other player
    /// When chooser is the player that steals cards
    case steal(CardArg, chooser: PlayerArg)
    
    /// Choose some cards from arena
    case chooseCard
    
    /// Draw a card from deck and put to arena
    case discover
    
    /// Set attribute turn
    case setTurn

    /// Eliminate a player from the game
    case eliminate
    
    /// Set player attribute
    case setAttribute(AttributeKey, value: Int)
    
    /// Increment player attribute
    case incAttribute(AttributeKey, value: Int)

    // MARK: - Operators

    /// Repeat an effect
    case `repeat`(times: NumArg, effect: Self)
    
    /// Dispatch effects sequentially
    case group([Self])
    
    /// Apply an effect to some players
    case target(target: PlayerArg, effect: Self)
    
    /// Try an effect. If cannot, then apply some effect
    case force(effect: Self, otherwise: Self)

    /// Force two players to perform an effect repeatedly. If cannot, then apply some effect
    case challenge(challenger: PlayerArg, effect: Self, otherwise: Self)
    
    /// Flip over the top card of the deck, then apply effects according to suits and values
    case luck(regex: String, onSuccess: Self, onFailure: Self? = nil)
    
    /// Cancel next queued effect
    case cancel

    /// Do nothing
    case nothing
}
