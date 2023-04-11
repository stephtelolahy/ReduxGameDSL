//
//  DrawDeckSpec.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

import Quick
import Nimble
import Game

final class DrawDeckSpec: QuickSpec {
    override func spec() {
        let sut: EffectReducer = effectReducer
        let ctx = PlayContext(actor: "p1", card: "cx")

        describe("draw deck") {
            context("containing cards") {
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
                    let effect = CardEffect.drawDeck(player: .id("p1"))
                    let result = try sut(effect, state, ctx)

                    // Then
                    expect(result.player("p1").hand.cards) == ["c1"]
                    expect(result.deck.top) == "c2"
                }
            }

            context("empty") {
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
                        let effect = CardEffect.drawDeck(player: .id("p1"))
                        let result = try sut(effect, state, ctx)

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
                        // Then
                        let effect = CardEffect.drawDeck(player: .id("p1"))
                        expect { try sut(effect, state, ctx) }
                            .to(throwError(GameError.stackIsEmpty))
                    }
                }
            }
        }
    }
}
