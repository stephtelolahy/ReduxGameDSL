//
//  ChooseCard.swift
//  
//
//  Created by Hugues Telolahy on 11/04/2023.
//

struct ChooseCard: GameReducerProtocol {
    func reduce(state: GameState, action: GameAction) throws -> GameState {
        guard case let .chooseCard(player, card) = action else {
            fatalError(.unexpected)
        }

        var state = state
        try state.arena?.remove(card)
        if state.arena?.cards.isEmpty == true {
            state.arena = nil
        }
        state[keyPath: \GameState.players[player]]?.hand.add(card)
        return state
    }
}

extension ChooseCard: EffectResolverProtocol {
    func resolve(effect: CardEffect, state: GameState, ctx: EffectContext) throws -> EffectOutput {
        guard case let .chooseCard(player, card) = effect else {
            fatalError(.unexpected)
        }

        guard case let .id(pId) = player else {
            return try PlayerArgResolver().resolving(arg: player, state: state, ctx: ctx) {
                CardEffect.chooseCard(player: .id($0), card: card).withCtx(ctx)
            }
        }

        return try CardArgResolver().resolving(arg: card, state: state, ctx: ctx, chooser: pId, owner: nil) {
            .chooseCard(player: pId, card: $0)
        }
    }
}
