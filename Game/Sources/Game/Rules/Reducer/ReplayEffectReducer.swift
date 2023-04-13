//
//  ReplayEffectReducer.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

struct ReplayEffectReducer: GameReducerProtocol {
    let effect: CardEffect
    let times: Int
    let ctx: PlayContext

    func reduce(state: GameState) throws -> GameState {
        guard times > 0 else {
            return state
        }

        let children = (0..<times).map { _ in
            effect.withCtx(ctx)
        }

        var state = state
        state.queue.insert(contentsOf: children, at: 0)
        return state
    }
}
