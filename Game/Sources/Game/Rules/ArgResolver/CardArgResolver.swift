//
//  CardArgResolver.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

protocol CardArgResolverProtocol {
    func resolve(state: GameState, ctx: EffectContext, chooser: String, owner: String?) throws -> ArgOutput
}

struct CardArgResolver {
    private func resolve(
        arg: CardArg,
        state: GameState,
        ctx: EffectContext,
        chooser: String,
        owner: String?
    ) throws -> ArgOutput {
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
        case let .identified(pIds):
            let children = pIds.map { copy($0) }
            state.queue.insert(contentsOf: children, at: 0)

        case let .selectable(pIdOptions):
            state.chooseOne = pIdOptions.map { copy($0.id) }
        }
        return state
    }
}

private extension CardArg {
    func resolver() -> CardArgResolverProtocol {
        switch self {
        case .selectAny:
            return CardSelectAny()

        case .selectChoosable:
            return CardSelectChoosable()

        default:
            fatalError(.unexpected)
        }
    }
}
