import Foundation

struct GameState: Codable {
    var game: Game
    var controlled: String?
}

enum GameAction {
    case endGame
    case playCard(id: String, actor: String)
    case endTurn(actor: String)
}

extension GameState {
    static let reducer: Reducer<Self, AppAction> = { state, action in
            state
    }
}
