//
//  NumExcessHand.swift
//  
//
//  Created by Hugues Telolahy on 02/05/2023.
//

struct NumExcessHand: NumArgResolverProtocol {
    func resolve(state: GameState, ctx: EffectContext) throws -> Int {
        let actorObj = state.player(ctx.actor)
        return max(actorObj.hand.count - actorObj.handLimitAtEndOfTurn(), 0)
    }
}

private extension Player {
    func handLimitAtEndOfTurn() -> Int {
        handLimit ?? health
    }
}
