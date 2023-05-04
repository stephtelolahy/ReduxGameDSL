//
//  ApplyEffect.swift
//  
//
//  Created by Hugues Telolahy on 22/04/2023.
//

struct ApplyEffect: GameReducerProtocol {
    func reduce(state: GameState, action: GameAction) throws -> GameState {
        guard case let .effect(effect, ctx) = action,
              case let .applyEffect(target, effect) = effect else {
            fatalError(.unexpected)
        }
        
        let targets = try PlayerArgResolver().resolve(arg: target, state: state, ctx: ctx)
        guard case let .identified(pIds) = targets else {
            fatalError(GameError.unexpected)
        }

        let children = pIds.map {
            effect.withCtx(EffectContext(actor: ctx.actor,
                                         card: ctx.card,
                                         target: $0))
        }

        var state = state
        state.queue.insert(contentsOf: children, at: 0)
        return state
    }
}
