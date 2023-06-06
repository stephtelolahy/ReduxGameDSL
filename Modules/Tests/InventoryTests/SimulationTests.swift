//
//  SimulationTests.swift
//  
//
//  Created by Hugues Stephano TELOLAHY on 06/06/2023.
//

import XCTest
import Game
import Inventory
import Combine

final class SimulationTests: XCTestCase {
    
    func testSimulateGame() {
        // Given
        let abilities: [String] = [
            .endTurn,
            .drawOnSetTurn,
            .eliminateOnLooseLastHealth,
            .nextTurnOnEliminated,
            .discardCardsOnEliminated,
        ]
        let figures = [
            Figure(name: "p1", bullets: 4, abilities: []),
            Figure(name: "p2", bullets: 3, abilities: [])
        ]
        let deck = Setup.createDeck(cardSets: CardSets.bang)
        
        let game = Setup.createGame(figures: figures,
                                    abilities: abilities,
                                    deck: deck)
            .cardRef(CardList.all)
        
        let sut = createGameStore(initial: game)
        
        let expectation = XCTestExpectation(description: "Awaiting game over")
        let cancellable = sut.$state.sink { state in
            if state.isOver != nil {
                expectation.fulfill()
            }
            
            if let active = state.active {
                let randomCard = active.cards.randomElement()!
                let move = GameAction.move(actor: active.player, card: randomCard)
                DispatchQueue.main.async {
                    sut.dispatch(move)
                }
            }
            
            if let chooseOne = state.chooseOne {
                let randomAction = chooseOne.options.values.randomElement()!
                DispatchQueue.main.async {
                    sut.dispatch(randomAction)
                }
            }
        }
        
        // When
        sut.dispatch(.setTurn("p1"))
        
        // Then
        wait(for: [expectation], timeout: 5.0)
        cancellable.cancel()
    }
}


