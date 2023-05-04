//
//  ReplayEffect.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

struct ReplayEffect: GameReducerProtocol {
    func reduce(state: GameState, action: GameAction) throws -> GameState {
        guard case let .effect(effect, ctx) = action,
              case let .replayEffect(times, effect) = effect else {
            fatalError(.unexpected)
        }
        
        let number = try NumArgResolver().resolve(arg: times, state: state, ctx: ctx)
        guard number > 0 else {
            return state
        }

        let children = (0..<number).map { _ in
            effect.withCtx(ctx)
        }

        var state = state
        state.queue.insert(contentsOf: children, at: 0)
        return state
    }
}
