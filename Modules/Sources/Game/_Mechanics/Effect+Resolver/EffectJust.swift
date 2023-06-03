//
//  EffectJust.swift
//  
//
//  Created by Hugues Telolahy on 18/05/2023.
//

struct EffectJust: EffectResolverProtocol {
    let action: GameAction

    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        [action]
    }
}
