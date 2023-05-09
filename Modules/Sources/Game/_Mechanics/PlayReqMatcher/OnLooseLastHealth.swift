//
//  OnLooseLastHealth.swift
//  
//
//  Created by Hugues Telolahy on 05/05/2023.
//

struct OnLooseLastHealth: PlayReqMatcherProtocol {
    func match(state: GameState, ctx: EffectContext) throws {
        guard case let .damage(player, _) = state.event,
              player == ctx.actor,
              (state.player(player).attributes[.health] ?? 0) <= 0 else {
            throw GameError.mismatched(.onSetTurn)
        }
    }
}
