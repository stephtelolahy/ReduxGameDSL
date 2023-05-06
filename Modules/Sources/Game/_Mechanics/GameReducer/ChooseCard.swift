//
//  ChooseCard.swift
//  
//
//  Created by Hugues Telolahy on 11/04/2023.
//

struct ChooseCard: GameReducerProtocol {
    func reduce(state: GameState, action: GameAction) throws -> GameState {
        guard case let .effect(effect, ctx) = action,
              case let .chooseCard(player, card) = effect else {
            fatalError(.unexpected)
        }
        
        guard case let .id(pId) = player else {
            return try PlayerArgResolver().resolve(arg: player, state: state, ctx: ctx) {
                CardEffect.chooseCard(player: .id($0), card: card).withCtx(ctx)
            }
        }
        
        guard case let .id(cId) = card else {
            return try CardArgResolver().resolve(arg: card, state: state, ctx: ctx, chooser: pId, owner: nil) {
                CardEffect.chooseCard(player: player, card: .id($0)).withCtx(ctx)
            }
        }

        var state = state
        try state.arena?.remove(cId)
        if state.arena?.cards.isEmpty == true {
            state.arena = nil
        }
        
        state[keyPath: \GameState.players[pId]]?.hand.add(cId)
        
        state.event = .chooseCard(player: pId, card: cId)
        
        return state
    }
}
