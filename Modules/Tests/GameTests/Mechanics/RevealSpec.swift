//
//  RevealSpec.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

@testable import Game
import Quick
import Nimble

final class RevealSpec: QuickSpec {
    override func spec() {
        let sut = GameReducer()
        let ctx = EffectContext(actor: "p1", card: "cx")

        describe("reveal") {
            context("chosable nil") {
                it("should draw top deck and create arena") {
                    // Given
                    let state = GameState {
                        Deck {
                            "c1"
                            "c2"
                            "c3"
                        }
                    }

                    // When
                    let action = CardEffect.reveal.withCtx(ctx)
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.arena?.cards) == ["c1"]
                    expect(result.deck.top) == "c2"
                    expect(result.event) == .reveal
                }
            }

            context("chosable containing card") {
                it("should draw top deck and add to arene") {
                    // Given
                    let state = GameState {
                        Deck {
                            "c2"
                            "c3"
                        }
                        Arena {
                            "c1"
                        }
                    }

                    // When
                    let action = CardEffect.reveal.withCtx(ctx)
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.arena?.cards) == ["c1", "c2"]
                    expect(result.deck.top) == "c3"
                    expect(result.event) == .reveal
                }
            }
        }
    }
}
