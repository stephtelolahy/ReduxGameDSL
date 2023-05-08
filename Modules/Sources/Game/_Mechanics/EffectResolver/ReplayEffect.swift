//
//  ReplayEffect.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

struct ReplayEffect: EffectResolverProtocol {
    func resolve(effect: CardEffect, state: GameState, ctx: EffectContext) throws -> [GameAction] {
        guard case let .replayEffect(times, effect) = effect else {
            fatalError(.unexpected)
        }
        
        let number = try NumArgResolver().resolve(arg: times, state: state, ctx: ctx)
        let children = (0..<number).map { _ in
            effect.withCtx(ctx)
        }

        return children
    }
}
