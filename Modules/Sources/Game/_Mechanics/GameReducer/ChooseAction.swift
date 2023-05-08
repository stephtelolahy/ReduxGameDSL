//
//  ChooseAction.swift
//  
//
//  Created by Hugues Telolahy on 08/05/2023.
//

struct ChooseAction: GameReducerProtocol {
    func reduce(state: GameState, action: GameAction) throws -> GameState {
        guard case let .chooseAction(chooser, options) = action else {
            fatalError(.unexpected)
        }

        var state = state
        state.chooseOne = ChooseOne(chooser: chooser, options: options)
        state.event = .chooseOne(chooser: chooser, options: Set(options.keys))
        return state
    }
}
