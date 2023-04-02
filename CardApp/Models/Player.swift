import Foundation

struct Player: Codable, Equatable {
    var name: String = ""
    var hand: [Card] = []
}
