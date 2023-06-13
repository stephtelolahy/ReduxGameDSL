//
//  CardEffect+Modifiers.swift
//  
//
//  Created by Hugues Telolahy on 23/04/2023.
//

public extension CardEffect {
    func `repeat`(_ times: NumArg) -> Self {
        .repeatEffect(times: times, effect: self)
    }
    
    func `repeat`(_ times: Int) -> Self {
        .repeatEffect(times: .exact(times), effect: self)
    }
    
    func target(_ target: PlayerArg) -> Self {
        .targetEffect(target: target, effect: self)
    }
    
    func card(_ card: CardArg, chooser: PlayerArg? = nil) -> Self {
        .cardEffect(card: card, chooser: chooser, effect: self)
    }
    
    func otherwise(_ effect: Self) -> Self {
        .forceEffect(effect: self, otherwise: effect)
    }
    
    func challenge(_ challenger: PlayerArg, otherwise: Self) -> Self {
        .challengeEffect(challenger: challenger, effect: self, otherwise: otherwise)
    }

    static func group(@CardEffectsBuilder content: () -> [Self]) -> Self {
        .groupEffects(content())
    }
    
    func triggered(_ eventReq: EventReq) -> CardAction {
        .init(eventReq: eventReq, effect: self, playReqs: [])
    }
}

extension CardAction {
    func require(@PlayReqBuilder playReqs: () -> [PlayReq]) -> Self {
        .init(eventReq: eventReq, effect: effect, playReqs: playReqs())
    }
}

extension CardEffect {
    func withCtx(_ ctx: EffectContext) -> GameAction {
        .resolve(self, ctx: ctx)
    }
}
