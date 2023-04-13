//
//  PlaySpec.swift
//
//
//  Created by Hugues Telolahy on 08/04/2023.
//

import Quick
import Nimble
import Game

final class PlaySpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        let sut = GameReducer()
        var action: GameAction!
        var result: GameState!

        describe("play") {
            context("hand card") {
                beforeEach {
                    // Given
                    let state = GameState {
                        Player("p1") {
                            Hand {
                                "beer-6♥️"
                            }
                        }
                        .health(2)
                        .maxHealth(4)
                        Player()
                        Player()
                    }
                    // When
                    action = GameAction.play(actor: "p1", card: "beer-6♥️")
                    result = sut.reduce(state: state, action: action)
                }

                it("should discard immediately") {
                    // Then
                    expect(result.player("p1").hand.cards).to(beEmpty())
                    expect(result.discard.top) == "beer-6♥️"
                }

                it("should emit completed action") {
                    // Then
                    expect(result.completedAction) == action
                }

                it("should queue side effects") {
                    // Then
                    let ctx = EffectContext(actor: "p1", card: "beer-6♥️")
                    expect(result.queue) == [CardEffect.heal(1, player: .actor).withCtx(ctx)]
                }
            }

            context("missing card") {
                it("should throw error") {
                    // Given
                    let state = GameState {
                        Player("p1")
                    }

                    // When
                    let action = GameAction.play(actor: "p1", card: "stagecoach-9♠️")
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.thrownError) == .missingCard("stagecoach-9♠️")
                }
            }

            context("missing player") {
                it("should throw error") {
                    // Given
                    let state = GameState()

                    // When
                    let action = GameAction.play(actor: "p1", card: "c1")
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.thrownError) == .missingPlayer("p1")
                }
            }

            context("not playable card") {
                it("should throw error") {
                    // Given
                    let state = GameState {
                        Player("p1") {
                            Hand {
                                "c1"
                            }
                        }
                    }

                    // When
                    let action = GameAction.play(actor: "p1", card: "c1")
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.thrownError) == .cardNotPlayable("c1")
                }
            }
        }
    }
}
