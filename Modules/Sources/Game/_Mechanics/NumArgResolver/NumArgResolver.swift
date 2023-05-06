//
//  NumArgResolver.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

protocol NumArgResolverProtocol {
    func resolve(arg: NumArg, state: GameState, ctx: EffectContext) throws -> Int
}

struct NumArgResolver: NumArgResolverProtocol {
    func resolve(arg: NumArg, state: GameState, ctx: EffectContext) throws -> Int {
        try arg.resolver().resolve(arg: arg, state: state, ctx: ctx)
    }
}

private extension NumArg {
    func resolver() -> NumArgResolverProtocol {
        switch self {
        case .exact: return NumExact()

        case .numPlayers: return NumPlayers()

        case .excessHand: return NumExcessHand()
            
        case .playerAttr: return NumPlayerAttr()
        }
    }
}
