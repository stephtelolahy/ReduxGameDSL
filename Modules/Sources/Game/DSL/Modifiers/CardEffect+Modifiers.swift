//
//  CardEffect+Modifiers.swift
//  
//
//  Created by Hugues Telolahy on 23/04/2023.
//

public extension CardEffect {
    func replay(_ times: NumArg) -> Self {
        .replayEffect(times: times, effect: self)
    }

    func replay(_ times: Int) -> Self {
        .replayEffect(times: .exact(times), effect: self)
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
