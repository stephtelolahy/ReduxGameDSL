//
//  PlayerSelectAtRangeWithCard.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

struct PlayerSelectAtRangeWithCard: PlayerArgResolverProtocol {
    let distance: Int

    func resolve(state: GameState, ctx: EffectContext) throws -> ArgOutput {
        let others = state.playOrder
            .filter { $0 != ctx.actor }
            .filter { (state.player($0).hand.cards + state.player($0).inPlay.cards).isNotEmpty }

        guard others.isNotEmpty else {
            throw GameError.noPlayerAllowed
        }

        return .selectable(others.toOptions())
    }
}
