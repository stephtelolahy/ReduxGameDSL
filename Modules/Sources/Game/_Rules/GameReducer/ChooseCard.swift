//
//  ChooseCard.swift
//  
//
//  Created by Hugues Telolahy on 11/04/2023.
//

struct ChooseCard: GameReducerProtocol {
    let action: GameAction
    let player: PlayerArg
    let card: CardArg
    let ctx: EffectContext

    func reduce(state: GameState) throws -> GameState {
        var state = state
        
        guard case let .id(pId) = player else {
            return try PlayerArgResolver().resolve(arg: player, state: state, ctx: ctx) {
                .chooseCard(player: .id($0), card: card, ctx: ctx)
            }
        }

        guard case let .id(cId) = card else {
            return try CardArgResolver().resolve(arg: card, state: state, ctx: ctx, chooser: ctx.actor, owner: nil) {
                .chooseCard(player: player, card: .id($0), ctx: ctx)
            }
        }

        try state.choosable?.remove(cId)
        if state.choosable?.cards.isEmpty == true {
            state.choosable = nil
        }

        state[keyPath: \GameState.players[pId]]?.hand.add(cId)

        state.completedAction = action

        return state
    }
}
