//
//  NumArgResolver.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

protocol NumArgResolverProtocol {
    func resolve(state: GameState, ctx: EffectContext) throws -> Int
}

struct NumArgResolver {
    func resolve(arg: NumArg, state: GameState, ctx: EffectContext) throws -> Int {
        try arg.resolver().resolve(state: state, ctx: ctx)
    }
}

private extension NumArg {
    func resolver() -> NumArgResolverProtocol {
        switch self {
        case let .exact(number):
            return NumExact(number: number)

        case .numPlayers:
            return NumPlayers()

        case .excessHand:
            return NumExcessHand()
            
        case .startTurnCards:
            return NumStartTurnCards()
        }
    }
}
