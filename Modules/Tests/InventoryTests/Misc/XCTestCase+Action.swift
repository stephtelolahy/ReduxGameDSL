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
        choices: [String] = [],
        store: Store<GameState, GameAction>,
        timeout: TimeInterval = 0.1,
        file: StaticString = #file,
        line: UInt = #line
    ) -> [Result<GameAction, GameError>] {
        
        var choices = choices
        var result: [Result<GameAction, GameError>] = []
        let expectation = XCTestExpectation(description: "Awaiting game idle")
        expectation.isInverted = true
        let cancellable = store.$state.sink { state in
            if let action = state.completedAction {
                result.append(.success(action))
            }
            
            if let error = state.thrownError {
                result.append(.failure(error))
            }
            
            if let chooseOne = state.chooseOne,
               !choices.isEmpty,
               let choosenAction = chooseOne.options[choices.removeFirst()] {
                DispatchQueue.main.async {
                    store.dispatch(choosenAction)
                }
            }
            
            if state.queue.isEmpty && state.chooseOne == nil {
                expectation.fulfill()
            }
        }
        
        store.dispatch(action)
        
        wait(for: [expectation], timeout: timeout)
        cancellable.cancel()
        
        XCTAssertNil(store.state.chooseOne, "Game must be idle", file: file, line: line)
        
        return result
    }
    
    func awaitSequence(
        state: GameState,
        action: GameAction,
        choices: String...,
        timeout: TimeInterval = 0.1,
        file: StaticString = #file,
        line: UInt = #line
    ) -> [Result<GameAction, GameError>] {
        let sut = createGameStore(initial: state)
        return awaitAction(action,
                           choices: choices,
                           store: sut,
                           timeout: timeout,
                           file: file,
                           line: line)
    }
    
}
