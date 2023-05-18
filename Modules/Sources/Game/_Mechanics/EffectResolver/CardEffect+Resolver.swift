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
        case let .heal(value): return BuildActionWithTarget { .heal(player: $0, value: value) }
        case let .damage(value): return BuildActionWithTarget { .damage(player: $0, value: value) }
        case let .discard(card, chooser): return EffectDiscard(card: card, chooser: chooser)
        case .draw: return BuildActionWithTarget { .draw(player: $0) }
        case let .steal(card, stealer): return EffectSteal(card: card, stealer: stealer)
        case .reveal: return BuildAction(action: .reveal)
        case .chooseCard: return EffectChooseCard()
        case .setTurn: return BuildActionWithTarget { .setTurn($0) }
        case .eliminate: return BuildActionWithTarget { .eliminate($0) }
        case let .targetEffect(target, effect): return TargetEffect(target: target, effect: effect)
        case let .groupEffects(effects): return GroupEffects(effects: effects)
        case let .repeatEffect(times, effect): return RepeatEffect(effect: effect, times: times)
        case let .forceEffect(effect, otherwise): return ForceEffect(effect: effect, otherwise: otherwise)
            // swiftlint:disable:next line_length
        case let .challengerEffect(challenger, effect, otherwise): return ChallengerEffect(challenger: challenger, effect: effect, otherwise: otherwise)
        case let .requireEffect(playReqs, effect): return RequireEffect(playReqs: playReqs, effect: effect)
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
