//
//  SelectReachable.swift
//  
//
//  Created by Hugues Telolahy on 17/04/2023.
//

struct SelectReachable: PlayerArgResolverProtocol {
    func resolve(state: GameState, ctx: EffectContext) throws -> PlayerArgOutput {
        .identified([])
    }
}
