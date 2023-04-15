//
//  CardEffect+Modifiers.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

extension CardEffect {
    static func replay(_ times: Int, @EffectBuilder content: () -> Self) -> Self {
        .replayEffect(times, content())
    }

    static func group(@EffectsBuilder content: () -> [Self]) -> Self {
        .groupEffects(content())
    }
}

public extension CardEffect {
    func withCtx(_ ctx: EffectContext) -> GameAction {
        .apply(self, ctx: ctx)
    }
}
