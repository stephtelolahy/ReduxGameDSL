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

    func apply(to target: PlayerGroupArg) -> Self {
        .applyEffect(target: target, effect: self)
    }

    func otherwise(_ effect: Self) -> Self {
        .forceEffect(effect: self, otherwise: effect)
    }

    func challenge(target: PlayerArg, challenger: PlayerArg, otherwise: Self) -> Self {
        .challengeEffect(target: target, challenger: challenger, effect: self, otherwise: otherwise)
    }

    static func group(@CardEffectsBuilder content: () -> [Self]) -> Self {
        .groupEffects(content())
    }
}

extension CardEffect {
    func withCtx(_ ctx: EffectContext) -> GameAction {
        .resolve(self, ctx: ctx)
    }
}
