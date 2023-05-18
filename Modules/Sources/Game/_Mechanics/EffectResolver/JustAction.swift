//
//  JustAction.swift
//  
//
//  Created by Hugues Telolahy on 18/05/2023.
//

struct JustAction: EffectResolverProtocol {
    let action: GameAction

    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        [action]
    }
}
