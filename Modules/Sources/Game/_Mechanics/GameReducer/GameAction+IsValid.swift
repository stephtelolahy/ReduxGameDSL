//
//  GameAction+IsValid.swift
//  
//
//  Created by Hugues Stephano TELOLAHY on 13/05/2023.
//

extension GameAction {
    func isValid(_ state: GameState) throws -> Bool {
        switch self {
        case let .play(actor, card, target):
            return try isValidPlay(actor: actor,
                                   card: card,
                                   target: target,
                                   state: state)
            
        case let .effect(effect, ctx: ctx):
            return try isValidEffect(effect: effect, ctx: ctx, state: state)

        case let .chooseAction(chooser, options):
            return try isValidChooseAction(chooser: chooser, options: options, state: state)
            
        default:
            return try isValidAction(action: self, state: state)
        }
    }
}

private extension GameAction {
 
    func isValidPlay(actor: String, card: String, target: String?, state: GameState) throws -> Bool {
        
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
        
        return try sideEffect.isValid(state)
    }
    
    func isValidEffect(effect: CardEffect, ctx: EffectContext, state: GameState) throws -> Bool {
        let children = try effect.resolve(state: state, ctx: ctx)
        
        for action in children {
            let result = try action.isValid(state)
            
            if !result {
                return false
            }
        }
        
        return true
    }

    func isValidChooseAction(chooser: String, options: [String: GameAction], state: GameState) throws -> Bool {
        for (key, action) in options {
            let result = try action.isValid(state)

            if !result {
                return false
            }
        }

        return true
    }
    
    func isValidAction(action: GameAction, state: GameState) throws -> Bool {
        _ = try action.reducer().reduce(state: state)
        return true
    }
}
