import Foundation
import Redux
import Game

struct GamePlayState: Codable, Equatable {
    var game: GameState?
    var controlled: String?
    var message: String = String()
}

enum GamePlayAction: Codable, Equatable {
    case onAppear
}

extension GamePlayState {
    static let reducer: Reducer<Self, Action> = { state, _ in
        state
    }
}
