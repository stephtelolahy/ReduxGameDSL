//
//  PlayerSelectAtRangeWithCard.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

struct PlayerSelectAtRangeWithCard: PlayerArgResolverProtocol {
    func resolve(arg: PlayerArg, state: GameState, ctx: EffectContext) throws -> PlayerArgOutput {
        guard case let .selectAtRangeWithCard(distance) = arg else {
            fatalError(.unexpected)
        }

        let others = state.playersAt(distance, from: ctx.actor)
            .filter { (state.player($0).hand.cards + state.player($0).inPlay.cards).isNotEmpty }

        guard others.isNotEmpty else {
            throw GameError.noPlayer(arg)
        }

        return .selectable(others)
    }
}
