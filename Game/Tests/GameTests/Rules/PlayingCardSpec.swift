//
//  PlayingCardSpec.swift
//
//
//  Created by Hugues Telolahy on 08/04/2023.
//

import Game
import Quick
import Nimble
import Redux

final class PlayingCardSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        var sut: Store<GameState, GameAction>!

        describe("playing") {
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
                    sut = createGameStore(initial: state)
                }

                it("should discard immediately") {
                    // When
                    let action = GameAction.play(actor: "p1", card: "beer-6♥️")
                    sut.dispatch(action)

                    // Then
                    let result = sut.state
                    expect(result.player("p1").hand.cards).to(beEmpty())
                    expect(result.discard.top) == "beer-6♥️"
                }

                it("should emit completed action") {
                    // When
                    let action = GameAction.play(actor: "p1", card: "beer-6♥️")
                    sut.dispatch(action)

                    // Then
                    let result = sut.state
                    expect(result.completedAction) == action
                }
            }

            context("missing card") {
                it("should throw error") {
                    // Given
                    let state = GameState {
                        Player("p1")
                    }
                    sut = createGameStore(initial: state)

                    // When
                    let action = GameAction.play(actor: "p1", card: "c1")
                    sut.dispatch(action)

                    // Then
                    let result = sut.state
                    expect(result.thrownError) == .missingCard("c1")
                }
            }

            context("missing player") {
                it("should throw error") {
                    // Given
                    let state = GameState()
                    sut = createGameStore(initial: state)

                    // When
                    let action = GameAction.play(actor: "p1", card: "c1")
                    sut.dispatch(action)

                    // Then
                    let result = sut.state
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
                    sut = createGameStore(initial: state)

                    // When
                    let action = GameAction.play(actor: "p1", card: "c1")
                    sut.dispatch(action)

                    // Then
                    let result = sut.state
                    expect(result.thrownError) == .cardNotPlayable("c1")
                }
            }
        }
    }
}
