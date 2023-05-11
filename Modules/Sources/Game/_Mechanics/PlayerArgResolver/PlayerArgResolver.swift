//
//  PlayerArgResolver.swift
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
        case let .identified(pIds):
            return pIds.map { copy($0) }
            
        case let .selectable(pIds):
            let options = pIds.reduce(into: [String: GameAction]()) {
                $0[$1] = copy($1)
            }
            return [.chooseAction(chooser: ctx.actor, options: options)]
        }
    }
    
    func resolve(state: GameState, ctx: EffectContext) throws -> PlayerArgOutput {
        try resolver().resolve(state: state, ctx: ctx)
    }
}

protocol PlayerArgResolverProtocol {
    func resolve(state: GameState, ctx: EffectContext) throws -> PlayerArgOutput
}

/// Resolved player argument
enum PlayerArgOutput {
    /// Appply effect to well known object identifiers
    case identified([String])
    
    /// Must choose one of given object identifiers
    case selectable([String])
}

private extension PlayerArg {
    // swiftlint:disable:next cyclomatic_complexity
    func resolver() -> PlayerArgResolverProtocol {
        switch self {
        case .actor: return PlayerActor()
        case .damaged: return PlayerDamaged()
        case .target: return PlayerTarget()
        case .selectAnyWithCard: return PlayerSelectAnyWithCard()
        case .all: return PlayerAll()
        case .others: return PlayerOthers()
        case let .selectAtRangeWithCard(distance): return PlayerSelectAtRangeWithCard(distance: distance)
        case .selectReachable: return PlayerSelectReachable()
        case let .selectAt(distance): return PlayerSelectAt(distance: distance)
        case .selectAny: return PlayerSelectAny()
        case .next: return PlayerNext()
        case .id: fatalError(.unexpected)
        }
    }
}
