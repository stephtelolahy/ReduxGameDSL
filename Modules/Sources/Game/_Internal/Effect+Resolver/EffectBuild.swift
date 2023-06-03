//
//  EffectBuild.swift
//  
//
//  Created by Hugues Telolahy on 18/05/2023.
//

/// Build an action with context target
struct EffectBuild: EffectResolverProtocol {
    let action: (String) -> GameAction

    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        let target = try ctx.getTarget()
        return [action(target)]
    }
}
