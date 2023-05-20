//
//  ChallengerEffect.swift
//  
//
//  Created by Hugues Telolahy on 13/05/2023.
//

struct ChallengerEffect: EffectResolverProtocol {
    let challenger: PlayerArg
    let effect: CardEffect
    let otherwise: CardEffect

    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        let target = try ctx.getTarget()

        guard case let .id(challengerId) = challenger else {
            return try challenger.resolve(state: state, ctx: ctx) {
                CardEffect.challengerEffect(challenger: .id($0),
                                            effect: effect,
                                            otherwise: otherwise)
                .withCtx(ctx)
            }
        }

        do {
            let children = try effect.resolve(state: state, ctx: ctx)

            guard children.count == 1 else {
                fatalError(.unexpected)
            }

            let action = children[0]
            switch action {
            case let .resolve(childEffect, childCtx):
                return [CardEffect.challengerEffect(challenger: challenger,
                                                    effect: childEffect,
                                                    otherwise: otherwise).withCtx(childCtx)]

            case let .chooseOne(chooser, options):
                let reversedAction = CardEffect.challengerEffect(challenger: .id(target),
                                                                 effect: effect,
                                                                 otherwise: otherwise)
                    .withCtx(EffectContext(actor: ctx.actor, card: ctx.card, target: challengerId))
                var options = options.mapValues { childAction in
                    GameAction.group {
                        childAction
                        reversedAction
                    }
                }
                options[.pass] = otherwise.withCtx(ctx)
                return [.chooseOne(chooser: chooser, options: options)]

            default:
                fatalError(.unexpected)
            }
        } catch {
            guard let target = ctx.target else {
                fatalError(.unexpected)
            }

            return [.chooseOne(chooser: target, options: [.pass: otherwise.withCtx(ctx)])]
        }
    }
}
