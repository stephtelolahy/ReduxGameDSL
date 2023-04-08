//
//  BeerTests.swift
//  
//
//  Created by Hugues Telolahy on 08/04/2023.
//

import XCTest
import Game

final class BeerTests: XCTestCase {

    func test_GainHealth_IfPlayingBeer() {
        // Given
        let ctx = GameState {
            Player("p1") {
                Hand {
                    "beer-6♥️"
                }
            }
            .health(2)
        }
        let store = createGameStore(initial: ctx)

        // When
        let action = GameAction.play(actor: "p1", card: "beer-6♥️")
        let result = awaitAction(action, store: store)

        // Then
        XCTAssertEqual(result, [
            .success(.play(actor: "p1", card: "beer-6♥️")),
            .success(.apply(.heal(1, player: .id("p1"))))
        ])
    }
}
