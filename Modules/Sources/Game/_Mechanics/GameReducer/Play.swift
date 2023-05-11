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

        // verify action
        let cardName = card.extractName()
        guard let cardObj = state.cardRef[cardName],
              let cardAction = cardObj.actions.first(where: { $0.actionType != .event }) else {
            throw GameError.cardNotPlayable(card)
        }

        // verify requirements
        let ctx = EffectContext(actor: actor, card: card, target: target)
        for playReq in cardAction.playReqs {
            try playReq.match(state: state, ctx: ctx)
        }

        if let requiredTarget = cardAction.target,
           target == nil {
            let children = try requiredTarget.resolve(state: state, ctx: ctx) {
                .play(actor: actor, card: card, target: $0)
            }
            var state = state
            state.queue.insert(contentsOf: children, at: 0)
            return state
        }

        var state = state

        // discard played hand card
        if case .play = cardAction.actionType {
            guard actorObj.hand.contains(card) else {
                throw GameError.cardNotFound(card)
            }

            try state[keyPath: \GameState.players[actor]]?.hand.remove(card)
            state.discard.push(card)
        }

        // queue side effects
        state.queue.append(cardAction.effect.withCtx(ctx))

        state.playCounter[card] = (state.playCounter[card] ?? 0) + 1

        state.event = .play(actor: actor, card: card, target: target)

        return state
    }
}
