//
//  EffectResolver.swift
//  
//
//  Created by Hugues Telolahy on 07/05/2023.
//

protocol EffectResolverProtocol {
    func resolve(effect: CardEffect, state: GameState, ctx: EffectContext) throws -> EffectOutput
}

enum EffectOutput {
    case actions([GameAction])
    case chooseOne(ChooseOne)
}

struct EffectResolver {
}
