import Foundation

/// All aspects of game state
/// Game is turn based, cards have actions, cards have properties and cards have rules
/// These state objects are passed around everywhere and maintained on both client and server seamlessly
public struct GameState: Codable, Equatable {

    /// all players
    public var players: [String: Player] = [:]

    /// active players, playing order
    public var playOrder: [String] = []

    /// current player
    public var turn: String?

    /// deck
    public var deck: CardStack = .init()

    /// discard pile
    public var discard: CardStack = .init()

    /// choosable cards
    public var choosable: CardLocation?

    /// is Game over
    public var isOver: Bool = false
    
    /// last completed action
    public var completedAction: GameAction?

    /// last occured error
    public var thrownError: GameError?

    /// queued actions
    public var queue: [GameAction] = []

    /// Pending actions to choose before continuing effect resolving
    public var chooseOne: [String: GameAction]?

    /// Number of times playing bang during a turn
    public var counterBang: Int = 0

    /// all cards reference
    public var cardRef: [String: Card] {
        CardList.cardRef
    }
}

// MARK: - Convenience

public extension GameState {

    /// Getting player with given identifier
    func player(_ id: String) -> Player {
        guard let player = players[id] else {
            fatalError(.playerNotFound(id))
        }
        return player
    }
}
