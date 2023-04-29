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
    ) -> [CodableResult<GameEvent, GameError>] {
        
        var choices = choices
        var result: [CodableResult<GameEvent, GameError>] = []
        let expectation = XCTestExpectation(description: "Awaiting game idle")
        expectation.isInverted = true
        let cancellable = store.$state.sink { state in
            if let event = state.event {
                result.append(event)
            }
            
            if case let .chooseOne(_, options) = state.queue.first,
                !choices.isEmpty,
               let choosenAction = options[choices.removeFirst()] {
                DispatchQueue.main.async {
                    store.dispatch(choosenAction)
                }
            }
            
            if state.queue.isEmpty {
                expectation.fulfill()
            }
        }
        
        store.dispatch(action)
        
        wait(for: [expectation], timeout: timeout)
        cancellable.cancel()
        
        return result
    }
    
    func awaitSequence(
        action: GameAction,
        choices: String...,
        state: GameState,
        timeout: TimeInterval = 0.1,
        file: StaticString = #file,
        line: UInt = #line
    ) -> [CodableResult<GameEvent, GameError>] {
        let sut = createGameStore(initial: state)
        let result = awaitAction(action,
                                 choices: choices,
                                 store: sut,
                                 timeout: timeout,
                                 file: file,
                                 line: line)
        XCTAssertTrue(sut.state.queue.isEmpty, "Game must be idle", file: file, line: line)
        return result
    }
}
