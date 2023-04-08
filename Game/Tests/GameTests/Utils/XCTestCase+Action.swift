//
//  Store+Action.swift
//  
//
//  Created by Hugues Telolahy on 08/04/2023.
//

import XCTest
import Redux
import Game

extension XCTestCase {

    func awaitAction(
        _ action: GameAction,
        store: Store<GameState, GameAction>,
        timeout: TimeInterval = 0.1,
        file: StaticString = #file,
        line: UInt = #line
    ) -> [Result<GameAction, GameError>] {

        var result: [Result<GameAction, GameError>] = []
        let expectation = XCTestExpectation(description: "Awaiting publisher")
        expectation.isInverted = true
        let cancellable = store.$state.sink { state in
            if let action = state.completedAction {
                result.append(.success(action))
            }
            if let error = state.thrownError {
                result.append(.failure(error))
            }
        }

        store.dispatch(action)

        wait(for: [expectation], timeout: timeout)
        cancellable.cancel()

        return result
    }
}
