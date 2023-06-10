//
//  OnLooseLastHealth.swift
//  
//
//  Created by Hugues Telolahy on 05/05/2023.
//

struct OnLooseLastHealth: EventReqMatcherProtocol {
    func match(state: GameState, ctx: PlayContext) -> Bool {
        guard case let .damage(player, _) = state.event,
              player == ctx.get(.actor),
              (state.player(player).attributes[.health] ?? 0) <= 0 else {
            return false
        }
        
        return true
    }
}
