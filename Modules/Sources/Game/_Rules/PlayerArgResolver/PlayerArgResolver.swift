//
//  PlayerArgResolver.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

protocol PlayerArgResolverProtocol {
    func resolve(state: GameState, ctx: EffectContext) throws -> PlayerArgOutput
}

struct PlayerArgResolver {
    func resolve(arg: PlayerArg, state: GameState, ctx: EffectContext) throws -> PlayerArgOutput {
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
            
        case let .selectable(pIds):
            let options = pIds.reduce(into: [String: GameAction]()) {
                $0[$1] = copy($1)
            }
            state.setChooseOne(chooser: ctx.actor, options: options)
        }
        
        return state
    }
}

private extension PlayerArg {
    // swiftlint:disable:next cyclomatic_complexity
    func resolver() -> PlayerArgResolverProtocol {
        switch self {
        case .id:
            fatalError(.unexpected)

        case .actor:
            return PlayerActor()
            
        case .damaged:
            return PlayerDamaged()
            
        case .target:
            return PlayerTarget()
            
        case .selectAnyWithCard:
            return PlayerSelectAnyWithCard()

        case .all:
            return PlayerAll()

        case .others:
            return PlayerOthers()

        case let .selectAtRangeWithCard(distance):
            return PlayerSelectAtRangeWithCard(distance: distance)

        case .selectReachable:
            return PlayerSelectReachable()

        case let .selectAt(distance):
            return PlayerSelectAt(distance: distance)

        case .selectAny:
            return PlayerSelectAny()

        case .next:
            return PlayerNext()
        }
    }
}
