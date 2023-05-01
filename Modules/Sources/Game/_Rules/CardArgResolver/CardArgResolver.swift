//
//  CardArgResolver.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

protocol CardArgResolverProtocol {
    func resolve(state: GameState, ctx: EffectContext, chooser: String, owner: String?) throws -> CardArgOutput
}

struct CardArgResolver {
    func resolve(
        arg: CardArg,
        state: GameState,
        ctx: EffectContext,
        chooser: String,
        owner: String?
    ) throws -> CardArgOutput {
        try arg.resolver().resolve(state: state, ctx: ctx, chooser: chooser, owner: owner)
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
        let resolved = try resolve(arg: arg, state: state, ctx: ctx, chooser: chooser, owner: owner)
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
        case .id:
            fatalError(.unexpected)

        case .selectAny:
            return CardSelectAny()

        case .selectChoosable:
            return CardSelectChoosable()

        case let .selectHandNamed(name):
            return CardSelectHandNamed(name: name)

        case .selectHand:
            return CardSelectHand()
        }
    }
}
