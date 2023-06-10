//
//  EffectRepeat.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

struct EffectRepeat: EffectResolverProtocol {
    let effect: CardEffect
    let times: NumArg
    
    func resolve(state: GameState, ctx: PlayContext) throws -> [GameAction] {
        let number = try times.resolve(state: state, ctx: ctx)
        return (0..<number).map { _ in
            effect.withCtx(ctx)
        }
    }
}
