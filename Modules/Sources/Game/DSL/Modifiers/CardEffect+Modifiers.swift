//
//  CardEffect+Modifiers.swift
//  
//
//  Created by Hugues Telolahy on 23/04/2023.
//

public extension CardEffect {
    static func replay(_ times: NumArg, @CardEffectBuilder content: () -> Self) -> Self {
        .replayEffect(times: times, effect: content())
    }

    static func replay(_ times: Int, @CardEffectBuilder content: () -> Self) -> Self {
        .replayEffect(times: .numExact(times), effect: content())
    }

    static func group(@CardEffectsBuilder content: () -> [Self]) -> Self {
        .groupEffects(content())
    }

    static func apply(target: PlayerArg, @CardEffectBuilder content: () -> Self) -> Self {
        .applyEffect(target: target, effect: content())
    }
}

extension CardEffect {
    func withCtx(_ ctx: EffectContext) -> GameAction {
        .effect(self, ctx: ctx)
    }
}
