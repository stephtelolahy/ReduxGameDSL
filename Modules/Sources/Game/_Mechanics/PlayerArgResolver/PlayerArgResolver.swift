//
//  PlayerArgResolver.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

protocol PlayerArgResolverProtocol {
    func resolve(arg: PlayerArg, state: GameState, ctx: EffectContext) throws -> PlayerArgOutput
}

/// Resolved player argument
enum PlayerArgOutput {
    /// Appply effect to well known object identifiers
    case identified([String])

    /// Must choose one of given object identifiers
    case selectable([String])
}

struct PlayerArgResolver: PlayerArgResolverProtocol {
    func resolve(arg: PlayerArg, state: GameState, ctx: EffectContext) throws -> PlayerArgOutput {
        try arg.resolver().resolve(arg: arg, state: state, ctx: ctx)
    }

    func resolving(
        arg: PlayerArg,
        state: GameState,
        ctx: EffectContext,
        copy: @escaping (String) -> GameAction
    ) throws -> [GameAction] {
        let resolved = try resolve(arg: arg, state: state, ctx: ctx)
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

        case .selectAtRangeWithCard: return PlayerSelectAtRangeWithCard()

        case .selectReachable: return PlayerSelectReachable()

        case .selectAt: return PlayerSelectAt()

        case .selectAny: return PlayerSelectAny()

        case .next: return PlayerNext()

        default: fatalError(.unexpected)
        }
    }
}
