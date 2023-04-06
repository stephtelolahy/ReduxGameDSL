import Foundation
import Game

public struct GameState: Codable, Equatable {
    var game: Game?
    var controlled: String?
    var message: String = ""
}

public enum GameAction: Codable, Equatable {
    case onAppear
}

extension GameState {
    static let reducer: Reducer<Self, GameAction> = { state, _ in
        state
    }
}
