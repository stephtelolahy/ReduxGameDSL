//
//  PlayerNext.swift
//  
//
//  Created by Hugues Telolahy on 01/05/2023.
//

struct PlayerNext: PlayerArgResolverProtocol {
    func resolve(arg: PlayerArg, state: GameState, ctx: EffectContext) throws -> PlayerArgOutput {
        guard let turn = state.turn,
              let next = state.playOrder.element(after: turn)else {
            fatalError(.unexpected)
        }

        return .identified([next])
    }
}
