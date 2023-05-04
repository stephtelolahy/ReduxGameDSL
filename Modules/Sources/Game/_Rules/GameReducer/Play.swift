//
//  Play.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

struct Play: GameReducerProtocol {
    let actor: String
    let card: String
    let target: String?

    func reduce(state: GameState) throws -> GameState {
        guard let actorObj = state.players[actor] else {
            throw GameError.playerNotFound(actor)
        }

        guard actorObj.hand.contains(card) else {
            throw GameError.cardNotFound(card)
        }

        // verify play action
        let cardName = card.extractName()
        guard let cardObj = state.cardRef[cardName],
              let action = cardObj.actions.first(where: { $0.actionType == .play }) else {
            throw GameError.cardIsNotPlayable(card)
        }

        // verify requirements
        let ctx = EffectContext(actor: actor, card: card, target: target)
        for playReq in action.playReqs {
            try PlayReqMatcher().match(playReq: playReq, state: state, ctx: ctx)
        }

        // resolve target
        if let requiredTarget = action.target,
           target == nil {
            return try PlayerArgResolver().resolve(arg: requiredTarget, state: state, ctx: ctx) {
                .play(actor: actor, card: card, target: $0)
            }
        }

        // discard immediately
        var state = state
        try state[keyPath: \GameState.players[actor]]?.hand.remove(card)
        state.discard.push(card)

        // queue side effects
        state.queue.append(action.effect.withCtx(ctx))

        state.event = .play(actor: actor, card: card, target: target)

        return state
    }
}
