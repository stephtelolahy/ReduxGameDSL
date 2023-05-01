//
//  ChooseCard.swift
//  
//
//  Created by Hugues Telolahy on 11/04/2023.
//

struct ChooseCard: GameReducerProtocol {
    let player: PlayerArg
    let card: CardArg
    let ctx: EffectContext
    
    func reduce(state: GameState) throws -> GameState {
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
        try state.choosable?.remove(cId)
        if state.choosable?.cards.isEmpty == true {
            state.choosable = nil
        }
        
        state[keyPath: \GameState.players[pId]]?.hand.add(cId)
        
        state.event = .chooseCard(player: pId, card: cId)
        
        return state
    }
}
