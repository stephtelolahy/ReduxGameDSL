//
//  GameAction+Modifiers.swift
//  
//
//  Created by Hugues Telolahy on 23/04/2023.
//

public extension GameAction {
    static func replay(_ times: NumArg, @GameActionBuilder content: () -> Self) -> Self {
        .replayEffect(times: times, effect: content())
    }

    static func replay(_ times: Int, @GameActionBuilder content: () -> Self) -> Self {
        .replayEffect(times: .numExact(times), effect: content())
    }

    static func group(@GameActionsBuilder content: () -> [Self]) -> Self {
        .groupEffects(content())
    }

    static func apply(target: PlayerArg, @GameActionBuilder content: () -> Self) -> Self {
        .applyEffect(target: target, effect: content())
    }
}

extension GameAction {
    func withCtx(_ ctx: EffectContext?) -> Self {
        var copy = self
        copy.ctx = ctx
        return copy
    }

    private var ctx: EffectContext? {
        get {
            fatalError(.unexpected)
        }
        set {
            switch self {
            case let .heal(value, player, _):
                self = .heal(value, player: player, ctx: newValue)

            case let .damage(value, player, _):
                self = .damage(value, player: player, ctx: newValue)

            case let .draw(player, _):
                self = .draw(player: player, ctx: newValue)

            case let .discard(player, card, _):
                self = .discard(player: player, card: card, ctx: newValue)

            case let .steal(player, target, card, _):
                self = .steal(player: player, target: target, card: card, ctx: newValue)

            case let .chooseCard(player, card, _):
                self = .chooseCard(player: player, card: card, ctx: newValue)

            case .reveal:
                break

            case let .forceDiscard(player, card, otherwise, _):
                self = .forceDiscard(player: player, card: card, otherwise: otherwise, ctx: newValue)

            case let .challengeDiscard(player, card, otherwise, challenger, _):
                self = .challengeDiscard(player: player,
                                         card: card,
                                         otherwise: otherwise,
                                         challenger: challenger,
                                         ctx: newValue)

            case let .replayEffect(times, effectToRepeat, _):
                self = .replayEffect(times: times, effect: effectToRepeat, ctx: newValue)

            case let .groupEffects(effects, _):
                self = .groupEffects(effects, ctx: newValue)

            case let .applyEffect(target, effect, _):
                self = .applyEffect(target: target, effect: effect, ctx: newValue)

            default:
                fatalError(.unexpected)
            }
        }
    }
}
