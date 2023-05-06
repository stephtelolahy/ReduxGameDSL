//
//  PlayerSelectAt.swift
//  
//
//  Created by Hugues Telolahy on 17/04/2023.
//

struct PlayerSelectAt: PlayerArgResolverProtocol {
    func resolve(arg: PlayerArg, state: GameState, ctx: EffectContext) throws -> PlayerArgOutput {
        guard case let .selectAt(distance) = arg else {
            fatalError(.unexpected)
        }

        let others = state.playersAt(distance, from: ctx.actor)
        guard others.isNotEmpty else {
            throw GameError.noPlayer(arg)
        }

        return .selectable(others)
    }
}
