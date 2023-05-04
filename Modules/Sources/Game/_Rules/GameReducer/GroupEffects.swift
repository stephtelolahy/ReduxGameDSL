//
//  GroupEffects.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

struct GroupEffects: GameReducerProtocol {
    func reduce(state: GameState, action: GameAction) throws -> GameState {
        guard case let .effect(effect, ctx) = action,
              case let .groupEffects(effects) = effect else {
            fatalError(.unexpected)
        }
        
        let children = effects.map { $0.withCtx(ctx) }
        var state = state
        state.queue.insert(contentsOf: children, at: 0)
        return state
    }
}
