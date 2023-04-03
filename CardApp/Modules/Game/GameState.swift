import Foundation
import Game

struct GameState: Codable, Equatable {
    var game: Game?
    var controlled: String?
    var moves: Int = 0
}

enum GameAction: Codable, Equatable {
    case onAppear
}

extension GameState {
    static let reducer: Reducer<Self, GameAction> = { state, action in
        state
    }
}
