//
//  Damage.swift
//  
//
//  Created by Hugues Telolahy on 16/04/2023.
//

struct Damage: GameReducerProtocol {
    let player: PlayerArg
    let value: Int
    let ctx: EffectContext?

    func reduce(state: GameState) throws -> GameState {
        var state = state

        guard case let .id(pId) = player else {
            return try PlayerArgResolver().resolve(arg: player, state: state, ctx: ctx!) {
                .damage(value, player: .id($0), ctx: ctx)
            }
        }

        // update health
        state[keyPath: \GameState.players[pId]]?.health -= value

        state.completedAction = .damage(value, player: player)

        return state
    }
}
