//
//  GameAction+Reducer.swift
//  
//
//  Created by Hugues Telolahy on 03/06/2023.
//

extension GameAction {
    func reduce(state: GameState) throws -> GameState {
        var state = state
        state = try reducer().reduce(state: state)
        return state
    }
}

protocol GameReducerProtocol {
    func reduce(state: GameState) throws -> GameState
}

private extension GameAction {
    // swiftlint:disable:next cyclomatic_complexity
    func reducer() -> GameReducerProtocol {
        switch self {
        case let .play(actor, card): return ActionPlay(actor: actor, card: card)
        case let .playImmediate(actor, card, target): return ActionPlayImmediate(actor: actor, card: card, target: target)
        case let .playAbility(actor, card): return ActionPlayAbility(actor: actor, card: card)
        case let .playEquipment(actor, card): return ActionPlayEquipment(actor: actor, card: card)
        case let .playHandicap(actor, card, target): return ActionPlayHandicap(actor: actor, card: card, target: target)
        case let .heal(value, player): return ActionHeal(player: player, value: value)
        case let .damage(value, player): return ActionDamage(player: player, value: value)
        case let .discard(player, card): return ActionDiscard(player: player, card: card)
        case let .draw(player): return ActionDraw(player: player)
        case let .steal(player, target, card): return ActionSteal(player: player, target: target, card: card)
        case .discover: return ActionDiscover()
        case .luck: return ActionLuck()
        case let .chooseCard(player, card): return ActionChooseCard(player: player, card: card)
        case let .group(actions): return ActionGroup(children: actions)
        case let .setTurn(player): return ActionSetTurn(player: player)
        case let .eliminate(player): return ActionEliminate(player: player)
        case let .resolve(effect, ctx): return ActionResolve(effect: effect, ctx: ctx)
        case let .chooseOne(chooser, options): return ActionChooseOne(chooser: chooser, options: options)
        case .cancel: return ActionCancel()
        default: fatalError("unimplemented action \(self)")
        }
    }
}
