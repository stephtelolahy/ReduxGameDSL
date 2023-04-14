//
//  DrawSpec.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

import Quick
import Nimble
import Game

final class DrawSpec: QuickSpec {
    override func spec() {
        let sut = GameReducer()
        let ctx = EffectContext(actor: "p1", card: "cx")

        describe("draw") {
            context("deck containing cards") {
                it("should remove top card") {
                    // Given
                    let state = GameState {
                        Player("p1")
                        Deck {
                            "c1"
                            "c2"
                        }
                    }

                    // When
                    let effect = CardEffect.draw(player: .id("p1"))
                    let result = sut.reduce(state: state, action: .apply(effect, ctx: ctx))

                    // Then
                    expect(result.player("p1").hand.cards) == ["c1"]
                    expect(result.deck.top) == "c2"
                }
            }

            context("deck empty") {
                context("enough discard pile") {
                    it("should reset deck") {
                        // Given
                        let state = GameState {
                            Player("p1")
                            DiscardPile {
                                "c1"
                                "c2"
                            }
                        }

                        // When
                        let effect = CardEffect.draw(player: .id("p1"))
                        let result = sut.reduce(state: state, action: .apply(effect, ctx: ctx))

                        // Then
                        expect(result.deck.top) == nil
                        expect(result.discard.top) == "c1"
                        expect(result.player("p1").hand.cards) == ["c2"]
                    }
                }

                context("not enough discard pile") {
                    it("should throw error") {
                        // Given
                        let state = GameState {
                            Player("p1")
                        }

                        // When
                        let effect = CardEffect.draw(player: .id("p1"))
                        let result = sut.reduce(state: state, action: .apply(effect, ctx: ctx))

                        // Then
                        expect(result.thrownError) == GameError.stackIsEmpty
                    }
                }
            }
        }
    }
}
