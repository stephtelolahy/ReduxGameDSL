//
//  GameAction+IsValid.swift
//  
//
//  Created by Hugues Stephano TELOLAHY on 13/05/2023.
//

extension GameAction {
    func validate(state: GameState) throws {
        switch self {
        case let .play(actor, card, target):
            try validatePlay(actor: actor,
                             card: card,
                             target: target,
                             state: state)
            
        case let .effect(effect, ctx: ctx):
            try validateEffect(effect: effect, ctx: ctx, state: state)

        case let .chooseAction(chooser, options):
            try validateChoose(chooser: chooser, options: options, state: state)
            
        default:
            try validateAction(action: self, state: state)
        }
    }
}

private extension GameAction {

    func validatePlay(actor: String, card: String, target: String?, state: GameState) throws {
        
        guard let actorObj = state.players[actor] else {
            throw GameError.playerNotFound(actor)
        }
        
        let cardName = card.extractName()
        guard let cardObj = state.cardRef[cardName],
              let cardAction = cardObj.actions.first(where: { !$0.isImmediate }) else {
            throw GameError.cardNotPlayable(card)
        }
        
        // verify requirements
        let ctx = EffectContext(actor: actor, card: card, target: target)
        for playReq in cardAction.playReqs {
            try playReq.match(state: state, ctx: ctx)
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
        
        let sideEffect = cardAction.effect.withCtx(ctx)
        
        try sideEffect.validate(state: state)
    }
    
    func validateEffect(effect: CardEffect, ctx: EffectContext, state: GameState) throws {
        let children = try effect.resolve(state: state, ctx: ctx)
        guard let action = children.first else {
            // Empty effect
            return
        }

        try action.validate(state: state)
    }

    func validateChoose(chooser: String, options: [String: GameAction], state: GameState) throws {
        for (_, action) in options {
            try action.validate(state: state)
        }
    }
    
    func validateAction(action: GameAction, state: GameState) throws {
        _ = try action.reducer().reduce(state: state)
    }
}
