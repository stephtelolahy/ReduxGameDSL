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
        case let .move(actor, card): return ActionMove(actor: actor, card: card)
        case let .playImmediate(actor, card, target): return ActionPlay(actor: actor, card: card, target: target)
        case let .playAbility(actor, card): return ActionSpell(actor: actor, card: card)
        case let .playEquipment(actor, card): return ActionEquip(actor: actor, card: card)
        case let .playHandicap(actor, card, target): return ActionHandicap(actor: actor, card: card, target: target)
        case let .heal(player, value): return ActionHeal(player: player, value: value)
        case let .damage(player, value): return ActionDamage(player: player, value: value)
        case let .discard(player, card): return ActionDiscard(player: player, card: card)
        case let .draw(player): return ActionDraw(player: player)
        case let .steal(player, target, card): return ActionSteal(player: player, target: target, card: card)
        case .drawToArena: return ActionDrawToArena()
        case let .chooseCard(player, card): return ActionChooseCard(player: player, card: card)
        case let .groupActions(actions): return ActionGroup(children: actions)
        case let .setTurn(player): return ActionSetTurn(player: player)
        case let .eliminate(player): return ActionEliminate(player: player)
        case let .resolve(effect, ctx): return ActionResolve(effect: effect, ctx: ctx)
        case let .chooseOne(chooser, options): return ActionChooseOne(chooser: chooser, options: options)
        }
    }
}
