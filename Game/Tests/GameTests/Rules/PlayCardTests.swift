//
//  PlayCardTests.swift
//  
//
//  Created by Hugues Telolahy on 06/04/2023.
//
import Game
import XCTest

final class PlayCardTests: XCTestCase {

    private let sut = GameState.reducer

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
        let action = GameAction.play(actor: "p1", card: "c1")
        let result = sut(ctx, action)

        // Then
        XCTAssertEqual(result.player("p1").hand.cards, ["c2"])
        XCTAssertEqual(result.discard.top, "c1")
        XCTAssertEqual(result.completedAction, action)
    }

    func test_FailToPlayCard_IfMissingCard() {
        // Given
        let ctx = GameState {
            Player("p1")
        }

        // When
        let action = GameAction.play(actor: "p1", card: "c1")
        let result = sut(ctx, action)

        // Then
        XCTAssertEqual(result.thrownError, .missingCard("c1"))
    }

    func test_FailToPlayCard_IfMissingPlayer() {
        // Given
        let ctx = GameState()

        // When
        let action = GameAction.play(actor: "p1", card: "c1")
        let result = sut(ctx, action)

        // Then
        XCTAssertEqual(result.thrownError, .missingPlayer("p1"))
    }
}
