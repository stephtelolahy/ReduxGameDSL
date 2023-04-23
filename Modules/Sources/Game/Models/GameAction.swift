//
//  GameAction.swift
//  
//
//  Created by Hugues Telolahy on 06/04/2023.
//

/// Function that causes any change in the game state
public indirect enum GameAction: Codable, Equatable {
    
    /// play a hand card
    case play(actor: String, card: String, target: String? = nil)

    /// process queued effects
    case update

    /// Restore player's health, limited to maxHealth
    case heal(Int, player: PlayerArg, ctx: EffectContext = .empty)

    /// Deals damage to a player, attempting to reduce its Health by the stated amount
    case damage(Int, player: PlayerArg, ctx: EffectContext = .empty)

    /// Draw top deck card
    case draw(player: PlayerArg, ctx: EffectContext = .empty)

    /// Discard a player's card to discard pile
    /// The card chooser is current actor
    case discard(player: PlayerArg, card: CardArg, ctx: EffectContext = .empty)

    /// Draw card from other player
    case steal(player: PlayerArg, target: PlayerArg, card: CardArg, ctx: EffectContext = .empty)

    /// Draw some cards from choosable zone
    case chooseCard(player: PlayerArg, card: CardArg, ctx: EffectContext = .empty)

    /// Draw a card from discard and put to choosable
    case reveal

    /// Player must choose to discard one of his card.
    /// If cannot, then apply some effect
    case forceDiscard(player: PlayerArg, card: CardArg, otherwise: GameAction, ctx: EffectContext = .empty)

    // Challenging other player to force discard
    // swiftlint:disable:next enum_case_associated_values_count line_length
    case challengeDiscard(player: PlayerArg, card: CardArg, otherwise: GameAction, challenger: PlayerArg, ctx: EffectContext = .empty)

    /// Repeat an effect
    case replayEffect(NumArg, GameAction, ctx: EffectContext = .empty)

    /// Dispatch effects sequentially
    case groupEffects([GameAction])

    /// Apply an effect to a group of players
    case applyEffect(PlayerArg, GameAction, ctx: EffectContext = .empty)
}

public extension EffectContext {
    static let empty: Self = .init(actor: "", card: "")
}
