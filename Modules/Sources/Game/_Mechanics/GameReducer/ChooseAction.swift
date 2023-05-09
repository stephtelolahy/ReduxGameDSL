//
//  ChooseAction.swift
//  
//
//  Created by Hugues Telolahy on 08/05/2023.
//

struct ChooseAction: GameReducerProtocol {
    let chooser: String
    let options: [String: GameAction]

    func reduce(state: GameState) throws -> GameState {
        var state = state
        state.chooseOne = ChooseOne(chooser: chooser, options: options)
        return state
    }
}
