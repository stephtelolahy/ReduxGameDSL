import Foundation

struct Game: Codable, Equatable {
    var players: [Player] = []
    var turn: String?
}

struct Player: Codable, Equatable {
    var name: String = ""
    var hand: [Card] = []
}
