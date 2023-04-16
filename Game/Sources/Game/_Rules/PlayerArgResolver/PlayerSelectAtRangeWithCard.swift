//
//  PlayerSelectAtRangeWithCard.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

struct PlayerSelectAtRangeWithCard: PlayerArgResolverProtocol {
    let distance: Int

    func resolve(state: GameState, ctx: EffectContext) throws -> PlayerArgOutput {
        let others = state.playersAt(distance, from: ctx.actor)
            .filter { (state.player($0).hand.cards + state.player($0).inPlay.cards).isNotEmpty }

        guard others.isNotEmpty else {
            throw GameError.noPlayerWithCard
        }

        return .selectable(others)
    }
}
