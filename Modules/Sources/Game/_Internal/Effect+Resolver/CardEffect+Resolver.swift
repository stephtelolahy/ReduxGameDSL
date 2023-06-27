//
//  CardEffect+Resolver.swift
//  
//
//  Created by Hugues Stephano TELOLAHY on 11/05/2023.
//

extension CardEffect {
    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        try resolver()
            .resolve(state: state, ctx: ctx)
            .simplifyChooseOne(state: state)
    }
}

protocol EffectResolverProtocol {
    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction]
}

private extension CardEffect {
    // swiftlint:disable:next cyclomatic_complexity
    func resolver() -> EffectResolverProtocol {
        switch self {
            // action with context
        case let .heal(value):
            return EffectBuild { .heal(value, player: $0.get(.target)) }

        case let .damage(value):
            return EffectBuild { .damage(value, player: $0.get(.target)) }

        case .draw:
            return EffectBuild { .draw(player: $0.get(.target)) }

        case .discover:
            return EffectBuild { _ in .discover }

        case .setTurn:
            return EffectBuild { .setTurn($0.get(.target)) }

        case .eliminate:
            return EffectBuild { .eliminate(player: $0.get(.target)) }

        case .chooseCard:
            return EffectChooseCard()

        case let .discard(card, chooser):
            return EffectDiscard(card: card, chooser: chooser)

        case let .steal(card, chooser):
            return EffectSteal(card: card, chooser: chooser)
            
        case let .passInplay(card, owner):
            return EffectPassInPlay(card: card, owner: owner)

            // operation on effect
        case let .target(target, effect):
            return EffectTarget(target: target, effect: effect)

        case let .group(effects):
            return EffectGroup(effects: effects)

        case let .repeat(times, effect):
            return EffectRepeat(effect: effect, times: times)

        case let .force(effect, otherwise):
            return EffectForce(effect: effect, otherwise: otherwise)

        case let .challenge(challenger, effect, otherwise):
            return EffectChallenge(challenger: challenger, effect: effect, otherwise: otherwise)
            
        case .nothing:
            return EffectNone()
            
        case let .luck(regex, onSuccess, onFailure):
            return EffectLuck(regex: regex, onSuccess: onSuccess, onFailure: onFailure)
            
        case .cancel:
            return EffectBuild { _ in .cancel }
            
        default:
            fatalError("unimplemented effect \(self)")
        }
    }
}

private extension Array where Element == GameAction {
    func simplifyChooseOne(state: GameState) throws -> Self {
        guard self.count == 1 else {
            return self
        }
        
        guard let simplified = try self[0].simplifyChooseOne(state: state) else {
            return self
        }
        
        return [simplified]
    }
}

private extension GameAction {
    func simplifyChooseOne(state: GameState) throws -> GameAction? {
        guard case .chooseOne(let chooser, var options) = self else {
            return nil
        }
        
        for (key, value) in options {
            if case let .resolve(optionEffect, optionCtx) = value {
                let resolvedAction = try optionEffect
                    .resolver()
                    .resolve(state: state, ctx: optionCtx)
                if resolvedAction.count == 1 {
                    options[key] = resolvedAction[0]
                }
            }
        }
        return .chooseOne(player: chooser, options: options)
    }
}
