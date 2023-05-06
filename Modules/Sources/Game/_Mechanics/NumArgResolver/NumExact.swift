//
//  NumExact.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

struct NumExact: NumArgResolverProtocol {
    func resolve(arg: NumArg, state: GameState, ctx: EffectContext) throws -> Int {
        guard case let .exact(number) = arg else {
            fatalError(.unexpected)
        }

        return number
    }
}
