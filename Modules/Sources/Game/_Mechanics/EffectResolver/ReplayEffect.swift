//
//  ReplayEffect.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

struct ReplayEffect: EffectResolverProtocol {
    let effect: CardEffect
    let times: NumArg
    
    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        let number = try NumArgResolver().resolve(arg: times, state: state, ctx: ctx)
        return (0..<number).map { _ in
            effect.withCtx(ctx)
        }
    }
}
