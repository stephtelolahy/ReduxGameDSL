//
//  ReplayEffectReducer.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//
import Redux

struct ReplayEffectReducer: ThrowableReducerProtocol {
    func reduce(state: GameState, action: GameAction) throws -> GameState {
        guard case let .apply(effect, ctx) = action,
              case let .replayEffect(times, childEffect) = effect else {
            fatalError(.unexpected)
        }

        guard times > 0 else {
            return state
        }

        let children = (0..<times).map { _ in
            childEffect.withCtx(ctx)
        }

        var state = state
        state.queue.insert(contentsOf: children, at: 0)
        return state
    }
}
