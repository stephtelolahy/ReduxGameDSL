import Foundation

struct Game: Codable {
    var players: [Player] = []
    var turn: String?
}
