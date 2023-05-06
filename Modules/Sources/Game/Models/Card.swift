import Foundation

/// Cards that are used in a game.
/// Cards can have a cost, can have multiple properties, define additional rules,
/// have actions that can be played and have side effects that happen when they are being played.
public struct Card: Codable, Equatable {
    
    /// Unique Name
    public let name: String
    
    /// Actions that can be performed with the card
    public var actions: [CardAction] = []
}

/// Describing card action
public struct CardAction: Codable, Equatable {
    
    /// The action type
    public let actionType: CardActionType

    /// The target to choose before performing the action
    public var target: PlayerArg?

    /// The requirements to match before activating the action
    public let playReqs: [PlayReq]
    
    /// The side effect after performing the action
    public let effect: CardEffect
}

/// Describing when card action is applied
public enum CardActionType: Codable, Equatable {
    
    /// Discard card and apply side effect
    case play

    /// Ability, just apply side effect
    case spell
    
//    /// Use card as self equipment
//    case equip
//
//    /// Use card as handicap againts another player
//    case handicap
//
//    /// Apply side effects immediately, when an event occurred
//    case triggered
}
