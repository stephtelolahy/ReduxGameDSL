//
//  PlayCardSpec.swift
//  
//
//  Created by Hugues Telolahy on 08/04/2023.
//

import XCTest
import Quick
import Game
import Redux

final class PlayCardSpec: QuickSpec {
    override func spec() {
        let sut = GameState.reducer
        let ctx = GameState {
            Player("p1") {
                Hand {
                    "c1"
                    "c2"
                }
            }
        }

        describe("playing") {

            context("hand card") {

                it("should discard immediately") {
                    // Given
                    // When
                    let action = GameAction.play(actor: "p1", card: "c1")
                    let result = sut(ctx, action)

                    // Then
                    XCTAssertEqual(result.player("p1").hand.cards, ["c2"])
                    XCTAssertEqual(result.discard.top, "c1")
                }

                it("should emit completed action") {
                    // Given
                    // When
                    let action = GameAction.play(actor: "p1", card: "c1")
                    let result = sut(ctx, action)

                    // Then
                    XCTAssertEqual(result.completedAction, action)
                }
            }

            context("missing card") {
                it("should throw error") {
                    // Given
                    // When
                    let action = GameAction.play(actor: "p1", card: "c3")
                    let result = sut(ctx, action)

                    // Then
                    XCTAssertEqual(result.thrownError, .missingCard("c3"))
                }
            }

            context("missing player") {
                it("should throw error") {
                    // When
                    let action = GameAction.play(actor: "p2", card: "c1")
                    let result = sut(ctx, action)

                    // Then
                    XCTAssertEqual(result.thrownError, .missingPlayer("p2"))
                }
            }
        }
    }
}
