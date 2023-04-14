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
                CardEffect.chooseCard(player: .id($0), card: card).withCtx(ctx)
            }
        }

        // choose card
        guard case let .id(cId) = card else {
            let resolved = try CardArgResolver()
                .resolve(arg: card, state: state, ctx: ctx, chooser: ctx.actor, owner: nil)
            switch resolved {
            case let .identified(cIds):
                let children = cIds.map {
                    CardEffect.chooseCard(player: player, card: .id($0)).withCtx(ctx)
                }
                state.queue.insert(contentsOf: children, at: 0)

            case let .selectable(cIdOptions):
                state.chooseOne = cIdOptions.map {
                    .apply(.chooseCard(player: player, card: .id($0.id)), ctx: ctx)
                }
            }

            return state
        }

        try state.choosable?.remove(cId)
        state[keyPath: \GameState.players[pId]]?.hand.add(cId)

        state.completedAction = action

        return state
    }
}
