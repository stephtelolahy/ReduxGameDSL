//
//  PlayerArg+Resolver.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

extension PlayerArg {
    func resolve(
        state: GameState,
        ctx: EffectContext,
        copy: @escaping (String) -> GameAction
    ) throws -> [GameAction] {
        let resolved = try resolve(state: state, ctx: ctx)
        switch resolved {
        case let .identified(pId):
            return [copy(pId)]
            
        case let .selectable(pIds):
            let options = pIds.reduce(into: [String: GameAction]()) {
                $0[$1] = copy($1)
            }
            return [.chooseAction(chooser: ctx.actor, options: options)]
        }
    }
    
    private func resolve(state: GameState, ctx: EffectContext) throws -> PlayerArgOutput {
        try resolver().resolve(state: state, ctx: ctx)
    }
}

protocol PlayerArgResolverProtocol {
    func resolve(state: GameState, ctx: EffectContext) throws -> PlayerArgOutput
}

/// Resolved player argument
enum PlayerArgOutput {
    /// Appply effect to well known object identifiers
    case identified(String)
    
    /// Must choose one of given object identifiers
    case selectable([String])
}

private extension PlayerArg {
    func resolver() -> PlayerArgResolverProtocol {
        switch self {
        case .actor: return PlayerActor()
        case .target: return PlayerTarget()
        case .selectAnyWithCard: return PlayerSelectAnyWithCard()
        case let .selectAtRangeWithCard(distance): return PlayerSelectAtRangeWithCard(distance: distance)
        case .selectReachable: return PlayerSelectReachable()
        case let .selectAt(distance): return PlayerSelectAt(distance: distance)
        case .selectAny: return PlayerSelectAny()
        case .next: return PlayerNext()
        case .id: fatalError(.unexpected)
        }
    }
}

extension PlayerGroupArg {
    func resolve(state: GameState, ctx: EffectContext) throws -> [String] {
        try resolver().resolve(state: state, ctx: ctx)
    }
}

protocol PlayerGroupArgResolverProtocol {
    func resolve(state: GameState, ctx: EffectContext) throws -> [String]
}

private extension PlayerGroupArg {
    func resolver() -> PlayerGroupArgResolverProtocol {
        switch self {
        case .damaged: return PlayerDamaged()
        case .all: return PlayerAll()
        case .others: return PlayerOthers()
        }
    }
}
