import Foundation

struct GameState: Codable, Equatable {
    var game: Game?
    var controlled: String?
    var moves: Int = 0
}

enum GameAction {
    case playCard(id: String, actor: String)
    case endTurn(actor: String)
}

extension GameState {
    static let reducer: Reducer<Self, GameAction> = { state, action in
            state
    }
}
