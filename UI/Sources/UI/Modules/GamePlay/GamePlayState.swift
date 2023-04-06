import Foundation
import Game

public struct GamePlayState: Codable, Equatable {
    var game: Game?
    var controlled: String?
    var message: String = ""
}

public enum GamePlayAction: Codable, Equatable {
    case onAppear
}

extension GamePlayState {
    static let reducer: Reducer<Self, AppAction> = { state, _ in
        state
    }
}
