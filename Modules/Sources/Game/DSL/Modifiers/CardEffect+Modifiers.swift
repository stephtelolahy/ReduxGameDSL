//
//  CardEffect+Modifiers.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

extension CardEffect {
    static func replay(_ times: NumArg, @EffectBuilder content: () -> Self) -> Self {
        .replayEffect(times, content())
    }

    static func replay(_ times: Int, @EffectBuilder content: () -> Self) -> Self {
        .replayEffect(.numExact(times), content())
    }

    static func group(@EffectsBuilder content: () -> [Self]) -> Self {
        .groupEffects(content())
    }

    static func apply(_ target: PlayerArg, @EffectBuilder content: () -> Self) -> Self {
        .applyEffect(target, content())
    }
}

public extension CardEffect {
    func withCtx(_ ctx: EffectContext) -> GameAction {
        .apply(self, ctx: ctx)
    }
}
