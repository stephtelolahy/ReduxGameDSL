//
//  EffectBuild.swift
//  
//
//  Created by Hugues Telolahy on 18/05/2023.
//

/// Build an action with context
struct EffectBuild: EffectResolverProtocol {
    let action: (PlayContext) -> GameAction

    func resolve(state: GameState, ctx: PlayContext) throws -> [GameAction] {
        return [action(ctx)]
    }
}
