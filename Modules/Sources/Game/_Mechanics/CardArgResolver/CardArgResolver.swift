//
//  CardArgResolver.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

protocol CardArgResolverProtocol {
    func resolve(
        arg: CardArg,
        state: GameState,
        ctx: EffectContext,
        chooser: String,
        owner: String?
    ) throws -> CardArgOutput
}

/// Resolved card argument
enum CardArgOutput {
    /// Appply effect to well known object identifiers
    case identified([String])

    /// Must choose one of given object identifiers
    case selectable([CardArgOption])
}

/// Selectable argument option
struct CardArgOption {

    /// Identifier
    let id: String

    /// Displayed label
    let label: String
}

extension Array where Element == String {
    func toCardOptions() -> [CardArgOption] {
        map { .init(id: $0, label: $0) }
    }
}

struct CardArgResolver: CardArgResolverProtocol {
    func resolve(
        arg: CardArg,
        state: GameState,
        ctx: EffectContext,
        chooser: String,
        owner: String?
    ) throws -> CardArgOutput {
        try arg.resolver().resolve(
            arg: arg,
            state: state,
            ctx: ctx,
            chooser: chooser,
            owner: owner
        )
    }

    // swiftlint:disable:next function_parameter_count
    func resolve(
        arg: CardArg,
        state: GameState,
        ctx: EffectContext,
        chooser: String,
        owner: String?,
        copy: @escaping (String) -> GameAction
    ) throws -> GameState {
        var state = state
        let resolved = try resolve(
            arg: arg,
            state: state,
            ctx: ctx,
            chooser: chooser,
            owner: owner
        )
        switch resolved {
        case let .identified(cIds):
            let children = cIds.map { copy($0) }
            state.queue.insert(contentsOf: children, at: 0)

        case let .selectable(cIdOptions):
            guard cIdOptions.isNotEmpty else {
                return state
            }

            let options = cIdOptions.reduce(into: [String: GameAction]()) {
                $0[$1.label] = copy($1.id)
            }
            state.setChooseOne(chooser: chooser, options: options)
        }
        return state
    }
}

private extension CardArg {
    func resolver() -> CardArgResolverProtocol {
        switch self {
        case .selectAny: return CardSelectAny()

        case .selectArena: return CardSelectArena()

        case .selectHandNamed: return CardSelectHandNamed()

        case .selectHand: return CardSelectHand()

        default: fatalError(.unexpected)
        }
    }
}
