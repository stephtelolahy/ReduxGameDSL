//
//  PlaySpec.swift
//
//
//  Created by Hugues Telolahy on 11/06/2023.
//

import Quick
import Nimble
import Game

final class PlaySpec: QuickSpec {
    override func spec() {
        let sut = GameReducer()

        describe("playing") {
            context("not playable card") {
                it("should throw error") {
                    // Given
                    let state = GameState {
                        Player("p1") {
                            Hand {
                                "missed"
                            }
                        }
                    }

                    // When
                    let action = GameAction.playImmediate(actor: "p1", card: "missed")
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.error) == .cardNotPlayable("missed")
                }
            }

            context("immediate card") {
                it("should discard immediately") {
                    // Given
                    let state = GameState {
                        Player("p1") {
                            Hand {
                                .beer
                            }
                        }
                        .attribute(.health, 1)
                        .attribute(.maxHealth, 3)
                        Player("p2")
                        Player("p3")
                    }
                    .cardRef(CardList.all)

                    // When
                    let action = GameAction.play(actor: "p1", card: .beer)
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.queue) == [
                        .playImmediate(actor: "p1", card: .beer)
                    ]
                    expect(result.error) == nil
                }
            }

            xcontext("equipment card") {
                it("should put in self's play") {
                    // Given
                    // When
                    // Then
                }
            }

            xcontext("handicap card") {
                it("should put in target's play") {
                    // Given
                    // When
                    // Then
                }
            }
        }
    }
}
