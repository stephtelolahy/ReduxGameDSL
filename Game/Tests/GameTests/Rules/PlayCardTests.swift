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
        let result = try sut(ctx, .play(actor: "p1", card: "c1"))

        // Assert
        XCTAssertEqual(result.player("p1").hand.cards, ["c2"])
        XCTAssertEqual(result.discard.top, "c1")
    }

    func test_FailToPlayCard_IfMissingCard() {
        // Given
        let ctx = GameState {
            Player("p1")
        }

        // When
        // Assert
        assert(try sut(ctx, .play(actor: "p1", card: "c1")), throws: GameError.missingCard("c1"))
    }

    func test_FailToPlayCard_IfMissingPlayer() {
        // Given
        let ctx = GameState()

        // When
        // Assert
        assert(try sut(ctx, .play(actor: "p1", card: "c1")), throws: GameError.missingPlayer("p1"))
    }
}
