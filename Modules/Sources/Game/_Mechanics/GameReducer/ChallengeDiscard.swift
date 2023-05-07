//
//  ChallengeDiscard.swift
//  
//
//  Created by Hugues Telolahy on 23/04/2023.
//

struct ChallengeDiscard: GameReducerProtocol {
    func reduce(state: GameState, action: GameAction) throws -> GameState {
        guard case let .effect(effect, ctx) = action,
              case let .challengeDiscard(player, card, otherwise, challenger) = effect else {
            fatalError(.unexpected)
        }
        
        // resolve player
        guard case let .id(pId) = player else {
            return try PlayerArgResolver().resolve(arg: player, state: state, ctx: ctx) {
                CardEffect.challengeDiscard(player: .id($0), card: card, otherwise: otherwise, challenger: challenger)
                    .withCtx(ctx)
            }
        }
        
        // resolving card
        let resolvedCard = try CardArgResolver().resolve(arg: card, state: state, ctx: ctx, chooser: pId, owner: pId)
        guard case let .selectable(cIdOptions) = resolvedCard else {
            fatalError(.unexpected)
        }
        
        // resolving challenger
        guard case let .id(challengerId) = challenger else {
            return try PlayerArgResolver().resolve(arg: challenger, state: state, ctx: ctx) {
                CardEffect.challengeDiscard(player: player, card: card, otherwise: otherwise, challenger: .id($0))
                    .withCtx(ctx)
            }
        }
        
        // request a choice:
        // - discard one of matching card
        // - or Pass
        let reversedCtx = EffectContext(actor: ctx.actor, card: ctx.card, target: challengerId)
        var options = cIdOptions.reduce(into: [String: GameAction]()) {
            let discardAction = GameAction.event(.discard(player: pId, card: $1.id))
            let reverseAction = CardEffect.challengeDiscard(player: challenger,
                                                            card: card,
                                                            otherwise: otherwise,
                                                            challenger: player).withCtx(reversedCtx)
            $0[$1.label] = GameAction.group {
                discardAction
                reverseAction
            }
        }
        options[.pass] = otherwise.withCtx(ctx)
        
        var state = state
        state.setChooseOne(chooser: pId, options: options)
        
        return state
    }
}
