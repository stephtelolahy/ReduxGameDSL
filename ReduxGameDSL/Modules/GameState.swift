import Foundation

public struct GameState: Codable {
    var game: Game = .init()
    var controlled: String?
}

public enum GameAction {
    case endGame
    case playCard(id: String, actor: String)
    case endTurn(actor: String)
}

public extension GameState {
    static let reducer: Reducer<Self, AppAction> = { state, action in
            .init()
    }
}
