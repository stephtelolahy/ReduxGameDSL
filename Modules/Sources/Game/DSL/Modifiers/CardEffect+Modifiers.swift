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

    func andThen(effect: () -> Self) -> Self {
        var array: [CardEffect] = []
        array.append(self)
        array.append(effect())
        return .groupEffects(array)
    }

    func apply(to target: PlayerGroupArg) -> Self {
        .applyEffect(target: target, effect: self)
    }
}

extension CardEffect {
    func withCtx(_ ctx: EffectContext) -> GameAction {
        .effect(self, ctx: ctx)
    }
}
