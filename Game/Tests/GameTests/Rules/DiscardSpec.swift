//
//  DiscardSpec.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//
@testable import Game
import Quick
import Nimble

final class DiscardSpec: QuickSpec {
    override func spec() {
        let sut: EffectReducer = discardReducer
        let ctx = PlayContext(actor: "p1", card: "cx")

        describe("discarding") {
            context("hand card") {
                it("should remove card from hand") {
                    // Given
                    let state = GameState {
                        Player("p1") {
                            Hand {
                                "c1"
                                "c2"
                            }
                        }
                    }

                    // When
                    let effect = CardEffect.discard(player: .id("p1"), card: .id("c1"))
                    let result = try sut(effect, state, ctx)

                    // Then
                    expect(result.player("p1").hand.cards) == ["c2"]
                    expect(result.discard.top) == "c1"
                }
            }

            context("inPlay card") {
                it("should remove card from inPlay") {
                    // Given
                    let state = GameState {
                        Player("p1") {
                            InPlay {
                                "c1"
                                "c2"
                            }
                        }
                    }

                    // When
                    let effect = CardEffect.discard(player: .id("p1"), card: .id("c1"))
                    let result = try sut(effect, state, ctx)

                    // Then
                    expect(result.player("p1").inPlay.cards) == ["c2"]
                    expect(result.discard.top) == "c1"
                }
            }

            context("missing card") {
                it("should throw error") {
                    let state = GameState {
                        Player("p1")
                    }

                    // When
                    // Then
                    let effect = CardEffect.discard(player: .id("p1"), card: .id("c1"))
                    expect(try sut(effect, state, ctx))
                        .to(throwError(GameError.missingCard("c1")))
                }
            }
        }
    }
}