import Foundation

/// Cards that are used in a game.
/// Cards can have a cost, can have multiple properties, define additional rules,
/// have actions that can be played and have side effects that happen when they are being played.
public struct Card: Codable, Equatable {

    /// Unique identifier
    public let id: String

    /// Name
    public var name: String = ""

    /// Actions that can be performed with the card
    public var actions: [CardAction] = []
}

/// Function defining card side effects
public struct CardAction: Codable, Equatable {

    /// The manner an action is dispatched
    public let type: CardActionType

    /// Side effect on dispatching action
    public let effect: CardEffect

    /// requirements for playing this card
    public let requirements: [PlayReq]
}

public enum CardActionType: Codable, Equatable {

    /// card is playable when your turn and requirments are met
    case play

    /// card is equipement when your turn and requirments are met
    case equip

    /// card is handicap when your turn and requirments are met
    case handicap

    /// the side effects are applyed as soon as requirements are met
    case triggered
}

/// Function defining card side effects
public enum CardEffect: Codable, Equatable {

    /// Draw top deck card
    case draw(player: String)

    /// Restore player's health, limited to maxHealth
    case heal(Int, player: String)

    /// Deals damage to a player, attempting to reduce its Health by the stated amount
    case damage(Int, player: String)

    /// Discard a player's card to discard pile
    /// Actor is the card chooser
    case discard

    /// Remove player from game
    case eliminate

    /// Flip over the top card of the deck, then apply effects according to suits and values
    case luck

    /// Set turn
    case setTurn

    /// Set game over
    case setGameOver

    /// Increment attribute
    case incrementAttribute

    /// Choose one of pending actions to proceed effect resolving
    case chooseOne

    /// Cancel some queued events
    case cancel
}

/// Function  defining constraints to play a card
public enum PlayReq: Codable, Equatable {

    /// Game is over
    case isGameOver

    /// The minimum number of active players is X
    case isPlayersAtLeast

    /// When just eliminated
    case onEliminated
}
