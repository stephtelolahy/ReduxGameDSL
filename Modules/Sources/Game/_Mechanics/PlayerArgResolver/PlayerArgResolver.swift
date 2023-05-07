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

    @available(*, deprecated, message: "")
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

    func resolving(
        arg: PlayerArg,
        state: GameState,
        ctx: EffectContext,
        copy: @escaping (String) -> GameAction
    ) throws -> EffectOutput {
        let resolved = try resolve(arg: arg, state: state, ctx: ctx)
        switch resolved {
        case let .identified(pIds):
            let children = pIds.map { copy($0) }
            return .actions(children)

        case let .selectable(pIds):
            let options = pIds.reduce(into: [String: GameAction]()) {
                $0[$1] = copy($1)
            }
            let chooseOne = ChooseOne(chooser: ctx.actor, options: options)
            return .chooseOne(chooseOne)
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
