//
//  SequenceBeerTests.swift
//  
//
//  Created by Hugues Telolahy on 08/04/2023.
//

import XCTest
import Redux
import Game
import Combine

final class SequenceBeerTests: XCTestCase {

    func test_ApplyEffectGainHealth_OnPlayingBeer() {
        // Given
        var completedActions: [GameAction] = []
        let ctx = GameState {
            Player("p1") {
                Hand {
                    "beer-6♥️"
                }
            }
            .health(2)
        }
        let store = createGameStore(initial: ctx)
        var cancellables = Set<AnyCancellable>()
        store.$state.sink { state in
            if let action = state.completedAction {
                completedActions.append(action)
            }
        }.store(in: &cancellables)

        // When
        let action = GameAction.play(actor: "p1", card: "beer-6♥️")
        store.dispatch(action)

        // Assert
        XCTAssertEqual(completedActions, [.play(actor: "p1", card: "beer-6♥️"),
                                          .apply(.heal(1, player: .id("p1")))])
    }
}
