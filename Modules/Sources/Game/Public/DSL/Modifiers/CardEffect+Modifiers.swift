//
//  CardEffect+Modifiers.swift
//  
//
//  Created by Hugues Telolahy on 23/04/2023.
//

public extension CardEffect {
    func `repeat`(_ times: NumArg) -> Self {
        .repeat(times: times, effect: self)
    }
    
    func `repeat`(_ times: Int) -> Self {
        .repeat(times: .exact(times), effect: self)
    }
    
    func target(_ target: PlayerArg) -> Self {
        .target(target: target, effect: self)
    }
    
    func card(_ card: CardArg, chooser: PlayerArg? = nil) -> Self {
        .cardEffect(card: card, chooser: chooser, effect: self)
    }
    
    func otherwise(_ effect: Self) -> Self {
        .force(effect: self, otherwise: effect)
    }
    
    func challenge(_ challenger: PlayerArg, otherwise: Self) -> Self {
        .challenge(challenger: challenger, effect: self, otherwise: otherwise)
    }

    static func group(@CardEffectsBuilder content: () -> [Self]) -> Self {
        .group(content())
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
