//
//  GroupEffects.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

struct GroupEffects: GameReducerProtocol {
    let effects: [CardEffect]
    let ctx: EffectContext

    func reduce(state: GameState) throws -> GameState {
        let children = effects.map { $0.withCtx(ctx) }
        var state = state
        state.queue.insert(contentsOf: children, at: 0)
        return state
    }
}
