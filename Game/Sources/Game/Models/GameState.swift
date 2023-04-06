import Foundation

/// All aspects of game state
/// Game is turn based, cards have actions, cards have properties and cards have rules
/// These state objects are passed around everywhere and maintained on both client and server seamlessly
public struct GameState: Codable, Equatable {

    /// all players
    public var players: [Player] = []

    /// current player
    public var turn: String?

    /// deck
    public var deck: CardStack = .init()

    /// discard pile
    public var discard: CardStack = .init()

    /// choosable zone
    public var choosable: CardLocation = .init()

    /// is Game over
    public var isOver: Bool = false

    /// Getting player with given identifier
    public func player(_ id: String) -> Player {
        guard let player = players.first(where: { $0.id == id }) else {
            fatalError("Missing player")
        }
        return player
    }
}
