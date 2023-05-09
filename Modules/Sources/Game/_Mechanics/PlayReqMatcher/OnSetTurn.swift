//
//  OnSetTurn.swift
//  
//
//  Created by Hugues Telolahy on 03/05/2023.
//

struct OnSetTurn: PlayReqMatcherProtocol {
    func match(state: GameState, ctx: EffectContext) throws {
        guard case let .setTurn(turn) = state.event,
              turn == ctx.actor else {
            throw GameError.mismatched(.onSetTurn)
        }
    }
}
