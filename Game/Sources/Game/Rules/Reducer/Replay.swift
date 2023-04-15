//
//  Replay.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

struct Replay: GameReducerProtocol {
    let times: Int
    let effect: CardEffect
    let ctx: EffectContext

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
