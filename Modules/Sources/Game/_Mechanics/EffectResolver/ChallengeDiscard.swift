//
//  ChallengeDiscard.swift
//  
//
//  Created by Hugues Telolahy on 23/04/2023.
//

struct ChallengeDiscard: EffectResolverProtocol {
    let player: PlayerArg
    let card: CardArg
    let otherwise: CardEffect
    let challenger: PlayerArg
    
    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        guard case let .id(pId) = player else {
            return try player.resolve(state: state, ctx: ctx) {
                CardEffect.challengeDiscard(player: .id($0), card: card, otherwise: otherwise, challenger: challenger)
                    .withCtx(ctx)
            }
        }

        guard case let .id(challengerId) = challenger else {
            return try challenger.resolve(state: state, ctx: ctx) {
                CardEffect.challengeDiscard(player: player, card: card, otherwise: otherwise, challenger: .id($0))
                    .withCtx(ctx)
            }
        }
        
        let resolvedCard = try card.resolve(state: state, ctx: ctx, chooser: pId, owner: pId)
        guard case let .selectable(cIdOptions) = resolvedCard else {
            fatalError(.unexpected)
        }
        
        // request a choice:
        // - discard one of matching card
        // - or Pass
        let reversedCtx = EffectContext(actor: ctx.actor, card: ctx.card, target: challengerId)
        var options = cIdOptions.reduce(into: [String: GameAction]()) {
            let discardAction = GameAction.discard(player: pId, card: $1.id)
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
        
        return [.chooseAction(chooser: pId, options: options)]
    }
}
