//
//  Play.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

struct Play: GameReducerProtocol {
    let action: GameAction
    let actor: String
    let card: String
    let target: String?

    func reduce(state: GameState) throws -> GameState {
        var state = state
        let ctx = EffectContext(actor: actor, card: card, target: target)

        // discard immediately
        guard state.players[actor] != nil else {
            throw GameError.playerNotFound(actor)
        }
        try state[keyPath: \GameState.players[actor]]?.hand.remove(card)
        state.discard.push(card)

        // verify play action
        let cardName = card.extractName()
        guard let cardObj = state.cardRef[cardName],
              let playAction = cardObj.actions.first(where: { $0.actionType == .play }) else {
            throw GameError.cardIsNotPlayable(card)
        }

        // verify requirements
        for playReq in playAction.playReqs {
            try PlayReqMatcher().match(playReq: playReq, state: state, ctx: ctx)
        }

        // resolve target
        if let requiredTarget = playAction.target,
           target == nil {
            return try PlayerArgResolver().resolve(arg: requiredTarget, state: state, ctx: ctx) {
                .play(actor: actor, card: card, target: $0)
            }
        }

        // queue side effects
        state.queue.append(playAction.effect.withCtx(ctx))

        state.completedAction = action

        return state
    }
}
