//
//  PlayCardTests.swift
//  
//
//  Created by Hugues Telolahy on 06/04/2023.
//
import Game
import XCTest

final class PlayCardTests: XCTestCase {

    func test_DiscardHandCard_IfPlayingIt() {
        // Given
        let ctx = GameState {
            Player("p1") {
                Hand {
                    "c1"
                    "c2"
                }
            }
        }

        // When
        let result = GameState.reducer(ctx, .play(actor: "p1", card: "c1"))

        // Assert
        XCTAssertEqual(result.player("p1").hand.cards, ["c2"])
        XCTAssertEqual(result.discard.top, "c1")
    }
}
