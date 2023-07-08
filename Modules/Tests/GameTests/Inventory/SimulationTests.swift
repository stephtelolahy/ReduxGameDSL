//
//  SimulationTests.swift
//  
//
//  Created by Hugues Stephano TELOLAHY on 06/06/2023.
//

import XCTest
import Game
import Combine

final class SimulationTests: XCTestCase {

    func testMultipleSimulations() {
        for _ in 1...100 {
            let playersCount = Int.random(in: 4...7)
            simulateGame(playersCount: playersCount)
        }
    }
    
    private func simulateGame(playersCount: Int) {
        print("🏁 Simulate Game \(playersCount)")
        // Given
        let abilities: [String] = [
            .endTurn,
            .drawOnSetTurn,
            .eliminateOnLooseLastHealth,
            .gameOverOnEliminated,
            .discardCardsOnEliminated,
            .nextTurnOnEliminated
        ]
        let figures = (1...playersCount).map { Figure(name: "p\($0)", bullets: 4, abilities: []) }
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
                // swiftlint:disable:next force_unwrapping
                let randomCard = active.cards.randomElement()!
                let randomAction = GameAction.play(randomCard, actor: active.player)
                DispatchQueue.main.async {
                    sut.dispatch(randomAction)
                }
            }
            
            if let chooseOne = state.chooseOne {
                // swiftlint:disable:next force_unwrapping
                let randomAction = chooseOne.options.values.randomElement()!
                DispatchQueue.main.async {
                    sut.dispatch(randomAction)
                }
            }
        }
        
        // When
        sut.dispatch(.setTurn("p1"))
        
        // Then
        wait(for: [expectation], timeout: 2.0)
        cancellable.cancel()
    }
}
