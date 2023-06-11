//
//  MoveSpec.swift
//  
//
//  Created by Hugues Telolahy on 11/06/2023.
//

import Quick
import Nimble
import Game

final class MoveSpec: QuickSpec {
    override func spec() {
        let sut = GameReducer()
        let beer = Card("beer") {
            CardEffect.heal(1)
                .target(.actor)
                .triggered(.onPlay)
        }
        let cardRef = ["beer": beer]

        describe("move") {
            context("brown card") {
                it("should discard immediately") {
                    // Given
                    let state = GameState {
                        Player("p1") {
                            Hand {
                                "beer"
                            }
                        }
                        .attribute(.health, 1)
                        .attribute(.maxHealth, 3)
                    }
                    .cardRef(cardRef)

                    // When
                    let action = GameAction.move(actor: "p1", card: "beer")
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.queue) == [
                        .play(actor: "p1", card: "beer")
                    ]
                    expect(result.error) == nil
                }
            }

            context("equipment card") {
                it("should put in self's play") {
                    // Given
                    // When
                    // Then
                }
            }

            context("handicap card") {
                it("should put in target's play") {
                    // Given
                    // When
                    // Then
                }
            }
        }
    }
}
