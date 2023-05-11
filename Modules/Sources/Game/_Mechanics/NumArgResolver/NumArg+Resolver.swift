//
//  NumArg+Resolver.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

extension NumArg {
    func resolve(state: GameState, ctx: EffectContext) throws -> Int {
        try resolver().resolve(state: state, ctx: ctx)
    }
}

protocol NumArgResolverProtocol {
    func resolve(state: GameState, ctx: EffectContext) throws -> Int
}

private extension NumArg {
    func resolver() -> NumArgResolverProtocol {
        switch self {
        case let .exact(number): return NumExact(number: number)
        case .numPlayers: return NumPlayers()
        case .excessHand: return NumExcessHand()
        case let .playerAttr(key): return NumPlayerAttr(key: key)
        }
    }
}
