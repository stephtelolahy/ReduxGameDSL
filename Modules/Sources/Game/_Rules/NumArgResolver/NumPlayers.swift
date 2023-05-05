//
//  NumPlayers.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

struct NumPlayers: NumArgResolverProtocol {
    func resolve(arg: NumArg, state: GameState, ctx: EffectContext) throws -> Int {
        state.playOrder.count
    }
}
