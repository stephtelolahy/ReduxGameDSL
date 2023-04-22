import Foundation

/// Cards that are used in a game.
/// Cards can have a cost, can have multiple properties, define additional rules,
/// have actions that can be played and have side effects that happen when they are being played.
public struct Card: Codable, Equatable {
    
    /// Name
    public let name: String
    
    /// Actions that can be performed with the card
    public var actions: [CardActionInfo] = []
}

/// Describing card action
public struct CardActionInfo: Codable, Equatable {
    
    /// The action type
    public let actionType: CardActionType

    /// The requirements to match before activating the action
    public let playReqs: [PlayReq]

    /// The target to choose before performing the action
    public var target: PlayerArg?
    
    /// The side effect after performing the action
    public let effect: CardEffect
}

/// Describing how to apply card action
public enum CardActionType: Codable, Equatable {
    
    /// Discard immediately and apply side effect
    case play
    
    /// Use card as self equipment
    case equip
    
    /// Use card as handicap againts another player
    case handicap
    
    /// Apply side effects immediately, when an event occurred
    case triggered
}
