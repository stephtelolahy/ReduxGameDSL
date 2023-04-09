//
//  PlayingCardSpec.swift
//  
//
//  Created by Hugues Telolahy on 08/04/2023.
//

import Game
import Quick
import Nimble

final class PlayingCardSpec: QuickSpec {
    override func spec() {
        // Given
        let sut = gameReducer
        let ctx = GameState {
            Player("p1") {
                Hand {
                    "beer-6♥️"
                    "c2"
                }
            }
            Player()
            Player()
        }

        describe("playing") {
            context("hand card") {
                it("should discard immediately") {
                    // When
                    let action = GameAction.play(actor: "p1", card: "beer-6♥️")
                    let result = sut(ctx, action)

                    // Then
                    expect(result.player("p1").hand.cards) == ["c2"]
                    expect(result.discard.top) == "beer-6♥️"
                }

                it("should emit completed action") {
                    // When
                    let action = GameAction.play(actor: "p1", card: "beer-6♥️")
                    let result = sut(ctx, action)

                    // Then
                    expect(result.completedAction) == action
                }
            }

            context("missing card") {
                it("should throw error") {
                    // When
                    let action = GameAction.play(actor: "p1", card: "c3")
                    let result = sut(ctx, action)

                    // Then
                    expect(result.thrownError) == .missingCard("c3")
                }
            }

            context("missing player") {
                it("should throw error") {
                    // When
                    let action = GameAction.play(actor: "p2", card: "c1")
                    let result = sut(ctx, action)

                    // Then
                    expect(result.thrownError) == .missingPlayer("p2")
                }
            }

            context("not playable card") {
                it("should throw error") {
                    // When
                    let action = GameAction.play(actor: "p1", card: "c2")
                    let result = sut(ctx, action)

                    // Then
                    expect(result.thrownError) == .cardNotPlayable("c2")
                }
            }
        }
    }
}
