//
//  Move.swift
//  
//
//  Created by Hugues Telolahy on 20/05/2023.
//

struct Move: GameReducerProtocol {
    let actor: String
    let card: String

    func reduce(state: GameState) throws -> GameState {
        fatalError()
    }

}
