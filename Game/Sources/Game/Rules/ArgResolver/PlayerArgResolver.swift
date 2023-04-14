//
//  PlayerArgResolver.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

protocol PlayerArgResolverProtocol {
    func resolve(state: GameState, ctx: EffectContext) throws -> ArgOutput
}

struct PlayerArgResolver {
    func resolve(arg: PlayerArg, state: GameState, ctx: EffectContext) throws -> ArgOutput {
        try arg.resolver().resolve(state: state, ctx: ctx)
    }
}

private extension PlayerArg {
    func resolver() -> PlayerArgResolverProtocol {
        switch self {
        case .actor:
            return PlayerActor()
            
        case .damaged:
            return PlayerDamaged()
            
        case .target:
            return PlayerTarget()
            
        case .selectAnyWithCard:
            return PlayerSelectAnyWithCard()
            
        default:
            fatalError(.unexpected)
        }
    }
}
