import Foundation

/// All aspects of game state
/// Game is turn based, cards have actions, cards have properties and cards have rules
/// These state objects are passed around everywhere and maintained on both client and server seamlessly
struct Game: Codable, Equatable {

    /// all players
    var players: [Player] = []

    /// current player
    var turn: String?

    /// deck
    var deck: CardStack = .init()

    /// discard pile
    var discard: CardStack = .init()

    /// choosable zone
    var store: CardLocation = .init()

    /// is Game over
    var isOver: Bool = false

    /// last occurred event
//    var event: Result<Event, Error>?
}
