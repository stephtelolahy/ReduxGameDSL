//
//  PlayerArg+Resolver.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

extension PlayerArg {
    func resolve(
        state: GameState,
        ctx: [ContextKey: String],
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
            return [.chooseOne(chooser: ctx.get(.actor), options: options)]
        }
    }
    
    func resolve(state: GameState, ctx: [ContextKey: String]) throws -> PlayerArgOutput {
        let output = resolver().resolve(state: state, ctx: ctx)
        let pIds: [String]
        switch output {
        case let .identified(identifiers):
            pIds = identifiers

        case let .selectable(options):
            pIds = options
        }

        guard pIds.isNotEmpty else {
            throw GameError.noPlayer(self)
        }
        return output
    }
}

protocol PlayerArgResolverProtocol {
    func resolve(state: GameState, ctx: [ContextKey: String]) -> PlayerArgOutput
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
        case .target: return PlayerTarget()
        case .selectAnyWithCard: return PlayerSelectAnyWithCard()
        case .selectAtRangeWithCard(let distance): return PlayerSelectAtRangeWithCard(distance: distance)
        case .selectReachable: return PlayerSelectReachable()
        case .selectAt(let distance): return PlayerSelectAt(distance: distance)
        case .selectAny: return PlayerSelectAny()
        case .next: return PlayerNext()
        case .damaged: return PlayerDamaged()
        case .all: return PlayerAll()
        case .others: return PlayerOthers()
        default: fatalError(.unexpected)
        }
    }
}
