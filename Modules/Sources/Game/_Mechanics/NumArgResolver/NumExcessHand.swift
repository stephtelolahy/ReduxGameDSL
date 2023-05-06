//
//  NumExcessHand.swift
//  
//
//  Created by Hugues Telolahy on 02/05/2023.
//

struct NumExcessHand: NumArgResolverProtocol {
    func resolve(arg: NumArg, state: GameState, ctx: EffectContext) throws -> Int {
        let actorObj = state.player(ctx.actor)
        return max(actorObj.hand.count - actorObj.handLimitAtEndOfTurn(), 0)
    }
}

private extension Player {
    /// Your hand size limit, at the end of your turn, is equal to the life points you currently have
    func handLimitAtEndOfTurn() -> Int {
        handLimit ?? health
    }
}
