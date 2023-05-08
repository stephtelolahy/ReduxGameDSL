//
//  Play.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

struct Play: GameReducerProtocol {
    func reduce(state: GameState, action: GameAction) throws -> GameState {
        guard case let .play(actor, card, target) = action else {
            fatalError(.unexpected)
        }
        
        guard let actorObj = state.players[actor] else {
            throw GameError.playerNotFound(actor)
        }

        // verify action
        let cardName = card.extractName()
        guard let cardObj = state.cardRef[cardName],
              let action = cardObj.actions.first(where: { $0.actionType != .trigger }) else {
            throw GameError.cardNotPlayable(card)
        }

        // verify requirements
        let ctx = EffectContext(actor: actor, card: card, target: target)
        for playReq in action.playReqs {
            try PlayReqMatcher().match(playReq: playReq, state: state, ctx: ctx)
        }

        // resolve target
        if let requiredTarget = action.target,
           target == nil {
            let children = try PlayerArgResolver().resolving(arg: requiredTarget, state: state, ctx: ctx) {
                .play(actor: actor, card: card, target: $0)
            }
            var state = state
            state.queue.insert(contentsOf: children, at: 0)
            return state
        }

        var state = state

        // discard played hand card
        if case .play = action.actionType {
            guard actorObj.hand.contains(card) else {
                throw GameError.cardNotFound(card)
            }

            try state[keyPath: \GameState.players[actor]]?.hand.remove(card)
            state.discard.push(card)
        }

        // queue side effects
        state.queue.append(action.effect.withCtx(ctx))

        state.playCounter[card] = (state.playCounter[card] ?? 0) + 1

        state.event = .play(actor: actor, card: card, target: target)

        return state
    }
}
