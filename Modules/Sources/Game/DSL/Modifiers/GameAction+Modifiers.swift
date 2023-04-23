//
//  GameAction+Modifiers.swift
//  
//
//  Created by Hugues Telolahy on 23/04/2023.
//

extension GameAction {
    static func replay(_ times: NumArg, @GameActionBuilder content: () -> Self) -> Self {
        .replayEffect(times, content())
    }

    static func replay(_ times: Int, @GameActionBuilder content: () -> Self) -> Self {
        .replayEffect(.numExact(times), content())
    }

    static func group(@GameActionsBuilder content: () -> [Self]) -> Self {
        .groupEffects(content())
    }

    static func apply(target: PlayerArg, @GameActionBuilder content: () -> Self) -> Self {
        .applyEffect(target, content())
    }
}

public extension GameAction {
    func withCtx(_ ctx: EffectContext) -> Self {
        fatalError("This is changing enum context data")
    }
}
