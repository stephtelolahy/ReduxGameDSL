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

public struct CardActionInfo: Codable, Equatable {
    
    /// The action type
    public let actionType: CardActionType

    /// The target of the action
    public var target: ArgPlayer?
    
    /// Side effect
    public let effect: CardEffect
    
    /// requirements
    public var playReqs: [PlayReq] = []
}

public enum CardActionType: Codable, Equatable {
    
    /// card is playable when your turn and requirments are met
    case play
    
    /// card is equipement when your turn and requirments are met
    case equip
    
    /// card is handicap when your turn and requirments are met
    case handicap
    
    /// some side effects are applyed as soon as requirements are met
    case triggered
}
