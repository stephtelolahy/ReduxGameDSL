//
//  CardArgResolver.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

protocol CardArgResolverProtocol {
    func resolve(state: GameState, ctx: EffectContext, chooser: String, owner: String?) throws -> ArgOutput
}

struct CardArgResolver {
    func resolve(
        arg: CardArg,
        state: GameState,
        ctx: EffectContext,
        chooser: String,
        owner: String?
    ) throws -> ArgOutput {
        try arg.resolver().resolve(state: state, ctx: ctx, chooser: chooser, owner: owner)
    }
}

private extension CardArg {
    func resolver() -> CardArgResolverProtocol {
        switch self {
        case .selectAny:
            return CardSelectAny()

        case .selectChoosable:
            return CardSelectChoosable()

        default:
            fatalError(.unexpected)
        }
    }
}
