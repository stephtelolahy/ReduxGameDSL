//
//  GroupEffects.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

struct GroupEffects: GameReducerProtocol {
    let effects: [GameAction]
    let ctx: EffectContext?

    func reduce(state: GameState) throws -> GameState {
        var state = state
        let children = effects.map { $0.withCtx(ctx) }
        state.queue.insert(contentsOf: children, at: 0)
        return state
    }
}
