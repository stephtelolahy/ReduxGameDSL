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
                    let action = GameAction.reveal
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
                    let action = GameAction.reveal
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
