//
//  ChallengeEffect.swift
//  
//
//  Created by Hugues Telolahy on 13/05/2023.
//

struct ChallengeEffect: EffectResolverProtocol {
    let target: PlayerArg
    let challenger: PlayerArg
    let effect: CardEffect
    let otherwise: CardEffect

    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        guard case .id = target else {
            return try target.resolve(state: state, ctx: ctx) {
                CardEffect.challengeEffect(target: .id($0),
                                           challenger: challenger,
                                           effect: effect,
                                           otherwise: otherwise)
                .withCtx(ctx)
            }
        }

        guard case let .id(challengerId) = challenger else {
            return try challenger.resolve(state: state, ctx: ctx) {
                CardEffect.challengeEffect(target: target,
                                           challenger: .id($0),
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
            case let .effect(childEffect, childCtx):
                return [CardEffect.challengeEffect(target: target,
                                                   challenger: challenger,
                                                   effect: childEffect,
                                                   otherwise: otherwise).withCtx(childCtx)]

            case let .chooseOne(chooser, options):
                let reversedAction = CardEffect.challengeEffect(target: challenger,
                                                                challenger: target,
                                                                effect: effect.withTarget(challenger),
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

private extension CardEffect {
    func withTarget(_ target: PlayerArg) -> Self {
        switch self {
        case let .discard(_, card, chooser):
            return .discard(player: target, card: card, chooser: chooser)
            
        default:
            fatalError(.unexpected)
        }
    }
}
