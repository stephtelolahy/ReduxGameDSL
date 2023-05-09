//
//  EffectReducer.swift
//  
//
//  Created by Hugues Telolahy on 07/05/2023.
//

protocol EffectResolverProtocol {
    func resolve(effect: CardEffect, state: GameState, ctx: EffectContext) throws -> [GameAction]
}

struct EffectReducer: GameReducerProtocol {
    func reduce(state: GameState, action: GameAction) throws -> GameState {
        guard case let .effect(effect, ctx) = action else {
            fatalError(.unexpected)
        }
        
        let children = try effect
            .resolver()
            .resolve(effect: effect, state: state, ctx: ctx)
            .simplifyChooseAction(state: state)
        
        var state = state
        state.queue.insert(contentsOf: children, at: 0)
        return state
    }
}

private extension CardEffect {
    // swiftlint:disable:next cyclomatic_complexity
    func resolver() -> EffectResolverProtocol {
        switch self {
        case let .heal(value, player): return EffectHeal(player: player, value: value)
        case let .damage(value, player): return EffectDamage(player: player, value: value)
        case let .discard(player, card): return EffectDiscard(player: player, card: card)
        case .draw: return Draw()
        case .steal: return Steal()
        case .reveal: return Reveal()
        case .chooseCard: return ChooseCard()
        case .setTurn: return SetTurn()
        case .eliminate: return Eliminate()
        // swiftlint:disable:next line_length
        case let .forceDiscard(player, card, otherwise): return ForceDiscard(player: player, card: card, otherwise: otherwise)
        // swiftlint:disable:next line_length
        case let .challengeDiscard(player, card, otherwise, challenger): return ChallengeDiscard(player: player, card: card, otherwise: otherwise, challenger: challenger)
        case let .applyEffect(target, effect): return ApplyEffect(target: target, effect: effect)
        case let .groupEffects(effects): return GroupEffects(effects: effects)
        case let .replayEffect(times, effect): return ReplayEffect(effect: effect, times: times)
        }
    }
}

private extension Array where Element == GameAction {
    func simplifyChooseAction(state: GameState) throws -> Self {
        guard self.count == 1 else {
            return self
        }
        
        guard let simplified = try self[0].simplifyChooseAction(state: state) else {
            return self
        }
        
        return [simplified]
    }
}

private extension GameAction {
    func simplifyChooseAction(state: GameState) throws -> GameAction? {
        guard case .chooseAction(let chooser, var options) = self else {
            return nil
        }
        
        for (key, value) in options {
            if case let .effect(optionEffect, optionCtx) = value {
                let resolvedAction = try optionEffect
                    .resolver()
                    .resolve(effect: optionEffect, state: state, ctx: optionCtx)
                if resolvedAction.count == 1 {
                    options[key] = resolvedAction[0]
                }
            }
        }
        return .chooseAction(chooser: chooser, options: options)
    }
}
