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

    func target(_ target: PlayerArg) -> Self {
        .targetEffect(target: target, effect: self)
    }

    func otherwise(_ effect: Self) -> Self {
        .forceEffect(effect: self, otherwise: effect)
    }

    func challenge(_ challenger: PlayerArg, otherwise: Self) -> Self {
        .challengeEffect(challenger: challenger, effect: self, otherwise: otherwise)
    }

    func require(@PlayReqBuilder playReqs: () -> [PlayReq]) -> Self {
        .requireEffect(playReqs: playReqs(), effect: self)
    }

    static func group(@CardEffectsBuilder content: () -> [Self]) -> Self {
        .groupEffects(content())
    }

    func triggered(_ eventReq: EventReq) -> CardAction {
        .init(eventReq: eventReq, effect: self)
    }
}

extension CardEffect {
    func withCtx(_ ctx: EffectContext) -> GameAction {
        .resolve(self, ctx: ctx)
    }
}
