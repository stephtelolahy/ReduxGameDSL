//
//  IsCurrentTurn.swift
//  
//
//  Created by Hugues Telolahy on 16/05/2023.
//

struct IsCurrentTurn: PlayReqMatcherProtocol {
    func match(state: GameState, ctx: [ContextKey: String]) -> Bool {
        state.turn == ctx.get(.actor)
    }
}
