//
//  Store+Action.swift
//  
//
//  Created by Hugues Telolahy on 08/04/2023.
//

@testable import Game
import XCTest
import Redux

extension XCTestCase {
    
    func awaitAction(
        _ action: GameAction,
        choices: [String] = [],
        state: GameState,
        timeout: TimeInterval = 0.1,
        file: StaticString = #file,
        line: UInt = #line
    ) -> [Result<GameEvent, GameError>] {
        let store = createGameStore(initial: state)
        var choices = choices
        var result: [Result<GameEvent, GameError>] = []
        let expectation = XCTestExpectation(description: "Awaiting game idle")
        expectation.isInverted = true
        let cancellable = store.$state.dropFirst(1).sink { state in
            if let event = state.event {
                result.append(.success(event))
            }
            
            if let error = state.error {
                result.append(.failure(error))
            }
            
            if let chooseOne = state.chooseOne {
                guard !choices.isEmpty else {
                    XCTFail("Expected a choice between \(chooseOne.options.keys)", file: file, line: line)
                    return
                }
                
                let choice = choices.removeFirst()
                guard let choosenAction = chooseOne.options[choice] else {
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
        XCTAssertTrue(store.state.chooseOne == nil, "Game must be idle", file: file, line: line)
        
        return result
    }
}
