//
//  BuildActionWithTarget.swift
//  
//
//  Created by Hugues Telolahy on 18/05/2023.
//

struct BuildActionWithTarget: EffectResolverProtocol {
    let action: (String) -> GameAction

    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        guard let target = ctx.target else {
            throw GameError.noPlayer(.target)
        }

        return [action(target)]
    }
}
