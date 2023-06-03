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
        case .heal(let value): return EffectBuild { .heal(player: $0.getTarget(), value: value) }
        case .damage(let value): return EffectBuild { .damage(player: $0.getTarget(), value: value) }
        case .draw: return EffectBuild { .draw(player: $0.getTarget()) }
        case .drawToArena: return EffectBuild { _ in .drawToArena }
        case .setTurn: return EffectBuild { .setTurn($0.getTarget()) }
        case .eliminate: return EffectBuild { .eliminate($0.getTarget()) }
        case .chooseCard: return EffectBuild { .chooseCard(player: $0.getTarget(), card: $0.getCardSelected()) }
        case .steal: return EffectBuild { .steal(player: $0.actor, target: $0.getTarget(), card: $0.getCardSelected()) }

        case let .discard(card, chooser): return EffectDiscard(card: card, chooser: chooser)

        // operation on effect
        case let .targetEffect(target, effect): return EffectTarget(target: target, effect: effect)
        case let .cardEffect(card, chooser, effect): return EffectCard(card: card, chooser: chooser, effect: effect)
        case let .groupEffects(effects): return EffectGroup(effects: effects)
        case let .repeatEffect(times, effect): return EffectRepeat(effect: effect, times: times)
        case let .forceEffect(effect, otherwise): return EffectForce(effect: effect, otherwise: otherwise)
        // swiftlint:disable:next line_length
        case let .challengeEffect(challenger, effect, otherwise): return EffectChallenge(challenger: challenger, effect: effect, otherwise: otherwise)
        case let .requireEffect(playReqs, effect): return EffectRequire(playReqs: playReqs, effect: effect)
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
        return .chooseOne(chooser: chooser, options: options)
    }
}
