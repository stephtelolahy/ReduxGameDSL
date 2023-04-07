//
//  PlayCardTests.swift
//  
//
//  Created by Hugues Telolahy on 06/04/2023.
//
import Game
import XCTest

final class PlayCardTests: XCTestCase {

    func test_DiscardHandCard_IfPlayingIt() throws {
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
        let result = try GameState.reducer(ctx, .play(actor: "p1", card: "c1"))

        // Assert
        XCTAssertEqual(result.player("p1").hand.cards, ["c2"])
        XCTAssertEqual(result.discard.top, "c1")
    }

    func test_FailToPlayCard_IfCardNotInHand() {
        // Given
        let ctx = GameState {
            Player("p1")
        }

        // When
        // Assert
        assert(try GameState.reducer(ctx, .play(actor: "p1", card: "c1")), throws: GameError.missingCard("c1"))
    }
}
