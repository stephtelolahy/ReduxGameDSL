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
              let cardAction = cardObj.actions.first(where: { $0.eventReq == .onPlay }) else {
            throw GameError.cardNotPlayable(card)
        }
        
        let ctx = EffectContext(actor: actor, card: card, target: target)

        // validate action
        let action = GameAction.play(actor: actor, card: card, target: target)
        _ = try action.validate(state: state)

        // resolve target
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
        if actorObj.hand.contains(card) {
            try state[keyPath: \GameState.players[actor]]?.hand.remove(card)
            state.discard.push(card)
        }

        state.playCounter[card] = (state.playCounter[card] ?? 0) + 1

        state.event = .play(actor: actor, card: card, target: target)

        // queue side effects
        var sideEffect = cardAction.effect
        if case let .requireEffect(_, childEffect) = cardAction.effect {
            sideEffect = childEffect
        }

        state.queue.insert(sideEffect.withCtx(ctx), at: 0)

        return state
    }
}
