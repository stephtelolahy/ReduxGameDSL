//
//  OnEliminated.swift
//  
//
//  Created by Hugues Telolahy on 16/05/2023.
//

struct OnEliminated: EventReqMatcherProtocol {
    func match(state: GameState, ctx: [ContextKey: String]) -> Bool {
        guard case let .eliminate(player) = state.event,
              player == ctx.get(.actor) else {
            return false
        }

        return true
    }
}
