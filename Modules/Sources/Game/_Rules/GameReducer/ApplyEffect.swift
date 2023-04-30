//
//  ApplyEffect.swift
//  
//
//  Created by Hugues Telolahy on 22/04/2023.
//

struct ApplyEffect: GameReducerProtocol {
    let target: PlayerArg
    let effect: CardEffect
    let ctx: EffectContext
    
    func reduce(state: GameState) throws -> GameState {
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
