//
//  GameAction+Modifiers.swift
//  
//
//  Created by Hugues Telolahy on 23/04/2023.
//

extension GameAction {
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
    func withCtx(_ ctx: EffectContext) -> Self {
        var copy = self
        copy.ctx = ctx
        return copy
    }

    private var ctx: EffectContext {
        get {
            fatalError(.unexpected)
        }
        set {
            switch self {
            case let .heal(value, player, _): self = .heal(value, player: player, ctx: newValue)
            default: fatalError(.unexpected)
            }
        }
    }
}
