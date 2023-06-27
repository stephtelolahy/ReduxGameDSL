//
//  EffectPassInPlay.swift
//  
//
//  Created by Hugues Stephano TELOLAHY on 27/06/2023.
//

struct EffectPassInPlay: EffectResolverProtocol {
    let card: CardArg
    let owner: PlayerArg
    
    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        []
    }
}
