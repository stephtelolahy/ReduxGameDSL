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
        case let .heal(value, player): return EffectHeal(player: player, value: value)
        case let .damage(value, player): return EffectDamage(player: player, value: value)
        case let .discard(player, card, chooser): return EffectDiscard(player: player, card: card, chooser: chooser)
        case let .draw(player): return EffectDraw(player: player)
        case let .steal(player, target, card): return EffectSteal(player: player, target: target, card: card)
        case .reveal: return EffectReveal()
        case let .chooseCard(player, card): return EffectChooseCard(player: player, card: card)
        case let .setTurn(player): return EffectSetTurn(player: player)
        case let .eliminate(player): return EffectEliminate(player: player)
        case let .applyEffect(target, effect): return ApplyEffect(target: target, effect: effect)
        case let .groupEffects(effects): return GroupEffects(effects: effects)
        case let .replayEffect(times, effect): return ReplayEffect(effect: effect, times: times)
        case let .forceEffect(effect, otherwise): return ForceEffect(effect: effect, otherwise: otherwise)
            // swiftlint:disable:next line_length
        case let .challengeEffect(target, challenger, effect, otherwise): return ChallengeEffect(target: target, challenger: challenger, effect: effect, otherwise: otherwise)
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
            if case let .effect(optionEffect, optionCtx) = value {
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
