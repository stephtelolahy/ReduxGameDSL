//
//  Discard.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

struct Discard: GameReducerProtocol {
    let action: GameAction
    let player: PlayerArg
    let card: CardArg
    let ctx: EffectContext

    func reduce(state: GameState) throws -> GameState {
        var state = state
        
        guard case let .id(pId) = player else {
            return try PlayerArgResolver().resolve(arg: player, state: state, ctx: ctx) {
                CardEffect.discard(player: .id($0), card: card).withCtx(ctx)
            }
        }

        guard case let .id(cId) = card else {
            return try CardArgResolver().resolve(arg: card, state: state, ctx: ctx, chooser: ctx.actor, owner: pId) {
                CardEffect.discard(player: .id(pId), card: .id($0)).withCtx(ctx)
            }
        }

        try state[keyPath: \GameState.players[pId]]?.removeCard(cId)

        state.discard.push(cId)

        state.completedAction = action

        return state
    }
}

private extension Player {
    mutating func removeCard(_ card: String) throws {
        if hand.contains(card) {
            try hand.remove(card)
        } else if inPlay.contains(card) {
            try inPlay.remove(card)
        } else {
            throw GameError.missingCard(card)
        }
    }
}
