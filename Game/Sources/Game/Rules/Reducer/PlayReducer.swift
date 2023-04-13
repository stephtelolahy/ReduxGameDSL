//
//  PlayReducer.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

struct PlayReducer: GameReducerProtocol {
    let action: GameAction
    let actor: String
    let card: String
    let target: String?

    func reduce(state: GameState) throws -> GameState {
        guard state.players[actor] != nil else {
            throw GameError.missingPlayer(actor)
        }

        var state = state
        let ctx = PlayContext(actor: actor, card: card, target: target)

        // discard immediately
        try state[keyPath: \GameState.players[actor]]?.hand.remove(card)

        state.discard.push(card)

        // verify play action
        guard let cardName = card.extractName(),
              let cardObj = state.cardRef[cardName],
              let playAction = cardObj.actions.first(where: { $0.actionType == .play }) else {
            throw GameError.cardNotPlayable(card)
        }

        // resolve target
        if let requiredTarget = playAction.target,
           target == nil {
            let resolved = try argPlayerResolver(requiredTarget, state, ctx)
            switch resolved {
            case let .selectable(pIdOptions):
                state.chooseOne = pIdOptions.map { .play(actor: actor, card: card, target: $0.id) }

            default:
                fatalError(.unexpected)
            }

            return state
        }

        // verify requirements
        for playReq in playAction.playReqs {
            try PlayReqMatcher().match(playReq: playReq, state: state, ctx: ctx)
        }

        // queue side effects
        state.queue.append(playAction.effect.withCtx(ctx))

        state.completedAction = action

        return state
    }
}
