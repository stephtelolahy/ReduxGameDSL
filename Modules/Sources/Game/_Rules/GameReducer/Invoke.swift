//
//  Invoke.swift
//  
//
//  Created by Hugues Telolahy on 01/05/2023.
//

struct Invoke: GameReducerProtocol {
    func reduce(state: GameState, action: GameAction) throws -> GameState {
        guard case let .invoke(actor, card) = action else {
            fatalError(.unexpected)
        }
        
        // verify play action
        let cardName = card.extractName()
        guard let cardObj = state.cardRef[cardName],
              let action = cardObj.actions.first(where: { $0.actionType == .play }) else {
            throw GameError.cardIsNotPlayable(card)
        }

        // verify requirements
        let ctx = EffectContext(actor: actor, card: card)
        for playReq in action.playReqs {
            try PlayReqMatcher().match(playReq: playReq, state: state, ctx: ctx)
        }

        // queue side effects
        var state = state
        state.queue.append(action.effect.withCtx(ctx))

        state.event = .invoke(actor: actor, card: card)

        return state
    }
}
