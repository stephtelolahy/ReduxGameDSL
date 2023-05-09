//
//  NumExact.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

struct NumExact: NumArgResolverProtocol {
    let number: Int

    func resolve(arg: NumArg, state: GameState, ctx: EffectContext) throws -> Int {
        number
    }
}
