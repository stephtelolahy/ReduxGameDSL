import Foundation

struct Game: Codable, Equatable {
    var players: [Player] = []
    var turn: String?
}
