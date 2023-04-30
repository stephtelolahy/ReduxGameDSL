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
        let cancellable = store.$state.dropFirst(1).sink { state in
            if let event = state.event {
                result.append(event)
            }
            
            if case let .chooseOne(_, options) = state.queue.first {
                guard !choices.isEmpty else {
                    XCTFail("Expected a choice", file: file, line: line)
                    return
                }

                let choice = choices.removeFirst()
                guard let choosenAction = options[choice] else {
                    XCTFail("Expect a action matching choice \(choice)", file: file, line: line)
                    return
                }

                DispatchQueue.main.async {
                    store.dispatch(choosenAction)
                }
                return
            }
            
            if state.queue.isEmpty {
                expectation.fulfill()
            }
        }
        
        store.dispatch(action)
        
        wait(for: [expectation], timeout: timeout)
        cancellable.cancel()

        XCTAssertTrue(store.state.queue.isEmpty, "Game must be idle", file: file, line: line)
        
        return result
    }
    
    func awaitSequence(
        action: GameAction,
        choices: [String],
        state: GameState,
        timeout: TimeInterval = 0.1,
        file: StaticString = #file,
        line: UInt = #line
    ) -> [CodableResult<GameEvent, GameError>] {
        awaitAction(action,
                    choices: choices,
                    store: createGameStore(initial: state),
                    timeout: timeout,
                    file: file,
                    line: line)
    }
}
