//
//  NumStartTurnCards.swift
//  
//
//  Created by Hugues Stephano TELOLAHY on 02/05/2023.
//

struct NumStartTurnCards: NumArgResolverProtocol {
    func resolve(state: GameState, ctx: EffectContext) throws -> Int {
        let actorObj = state.player(ctx.actor)
        return actorObj.starTurnCards
    }
}
