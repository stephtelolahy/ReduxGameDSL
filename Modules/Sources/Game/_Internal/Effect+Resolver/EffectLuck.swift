//
//  EffectLuck.swift
//  
//
//  Created by Hugues Stephano TELOLAHY on 22/06/2023.
//

struct EffectLuck: EffectResolverProtocol {
    let regex: String
    let onSuccess: CardEffect
    let onFailure: CardEffect?
    
    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        fatalError("unimplemented")
    }
}
