import Foundation

/// All aspects of game state
/// Game is turn based, cards have actions, cards have properties and cards have rules
/// These state objects are passed around everywhere and maintained on both client and server seamlessly
public struct GameState: Codable, Equatable {

    /// All players
    public var players: [String: Player] = [:]

    /// Playing order
    public var playOrder: [String] = []

    /// Current turn's player
    public var turn: String?

    /// Current turn's number of times a card was played
    public var counters: [String: Int] = [:]

    /// Deck
    public var deck: CardStack = .init()

    /// Discard pile
    public var discard: CardStack = .init()

    /// Choosable cards
    public var choosable: CardLocation?

    /// Is Game over
    public var isOver: Bool = false
    
    /// Last completed action
    public var completedAction: GameAction?

    /// Last occured error
    public var thrownError: GameError?

    /// Queued effects
    public var queue: [GameAction] = []

    /// Pending actions to choose before continuing effect resolving
    public var chooseOne: ChooseOne?

    /// All cards reference
    public var cardRef: [String: Card] = [:]
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
