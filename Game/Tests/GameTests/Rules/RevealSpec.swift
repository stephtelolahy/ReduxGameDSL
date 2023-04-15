//
//  RevealSpec.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

import Quick
import Nimble
import Game

final class RevealSpec: QuickSpec {
    override func spec() {
        let sut = GameReducer()
        let ctx = EffectContext(actor: "p1", card: "cx")

        describe("reveal") {
            context("chosable nil") {
                it("should draw top deck and create choosable zone") {
                    // Given
                    let state = GameState {
                        Deck {
                            "c1"
                            "c2"
                            "c3"
                        }
                    }

                    // When
                    let action = GameAction.apply(.reveal, ctx: ctx)
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.choosable?.cards) == ["c1"]
                    expect(result.deck.top) == "c2"
                    expect(result.completedAction) == action
                }
            }

            context("chosable containing card") {
                it("should draw top deck and add to choosable zone") {
                    // Given
                    let state = GameState {
                        Deck {
                            "c2"
                            "c3"
                        }
                        Choosable {
                            "c1"
                        }
                    }

                    // When
                    let action = GameAction.apply(.reveal, ctx: ctx)
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.choosable?.cards) == ["c1", "c2"]
                    expect(result.deck.top) == "c3"
                    expect(result.completedAction) == action
                }
            }
        }
    }
}
