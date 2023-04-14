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
    private func resolve(arg: PlayerArg, state: GameState, ctx: EffectContext) throws -> ArgOutput {
        try arg.resolver().resolve(state: state, ctx: ctx)
    }
    
    func resolve(
        arg: PlayerArg,
        state: GameState,
        ctx: EffectContext,
        copy: @escaping (String) -> GameAction
    ) throws -> GameState {
        var state = state
        let resolved = try resolve(arg: arg, state: state, ctx: ctx)
        switch resolved {
        case let .identified(pIds):
            let children = pIds.map { copy($0) }
            state.queue.insert(contentsOf: children, at: 0)
            
        case let .selectable(pIdOptions):
            state.chooseOne = pIdOptions.map { copy($0.id) }
        }
        
        return state
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
