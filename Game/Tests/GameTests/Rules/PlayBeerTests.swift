//
//  PlayBeerTests.swift
//  
//
//  Created by Hugues Telolahy on 08/04/2023.
//

import XCTest
import Redux
import Game

final class PlayBeerTests: XCTestCase {

    func test_ApplyEffectGainHealth_OnPlayingBeer() {
        // Given
        var actions: [GameAction] = []
        let ctx = GameState {
            Player("p1") {
                Hand {
                    "c1"
                    "c2"
                }
            }
            .health(2)
        }
        let store = createStore(initial: ctx)

        // When
        let action = GameAction.play(actor: "p1", card: "c1")
        store.dispatch(action)

        // Assert
        XCTAssertEqual(actions, [.play(actor: "p1", card: "beer-6♥️"),
                                 .apply(.heal(1, player: .id("p1")))])
    }
}

func createStore(initial: GameState) -> Store<GameState, GameAction> {
    Store(initial: initial,
          reducer: GameState.reducer,
          middlewares: [cardEffectMiddleware])
}
