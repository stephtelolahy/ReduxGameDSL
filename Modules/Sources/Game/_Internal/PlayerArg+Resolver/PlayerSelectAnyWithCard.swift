//
//  PlayerSelectAnyWithCard.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

struct PlayerSelectAnyWithCard: PlayerArgResolverProtocol {
    func resolve(state: GameState, ctx: EffectContext) -> PlayerArgOutput {
        let others = state.playOrder
            .filter { $0 != ctx.actor }
            .filter { (state.player($0).hand.cards + state.player($0).inPlay.cards).isNotEmpty }
        return .selectable(others)
    }
}