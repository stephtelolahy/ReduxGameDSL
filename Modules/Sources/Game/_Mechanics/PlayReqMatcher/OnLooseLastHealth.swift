//
//  OnLooseLastHealth.swift
//  
//
//  Created by Hugues Telolahy on 05/05/2023.
//

struct OnLooseLastHealth: PlayReqMatcherProtocol {
    func match(playReq: PlayReq, state: GameState, ctx: EffectContext) throws {
        guard case let .damage(_, player) = state.event,
              player == ctx.actor,
              state.player(player).health <= 0 else {
            throw GameError.mismatched(playReq)
        }
    }
}
