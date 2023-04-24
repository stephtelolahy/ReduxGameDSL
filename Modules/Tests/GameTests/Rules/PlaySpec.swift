//
//  PlaySpec.swift
//
//
//  Created by Hugues Telolahy on 08/04/2023.
//

@testable import Game
import Quick
import Nimble

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
                                .beer
                            }
                        }
                        .health(2)
                        .maxHealth(4)
                        Player()
                        Player()
                    }
                    // When
                    action = GameAction.play(actor: "p1", card: .beer)
                    result = sut.reduce(state: state, action: action)
                }

                it("should discard immediately") {
                    // Then
                    expect(result.player("p1").hand.cards).to(beEmpty())
                    expect(result.discard.top) == .beer
                }

                it("should emit completed action") {
                    // Then
                    expect(result.completedAction) == action
                }

                it("should queue side effects") {
                    // Then
                    let ctx = EffectContext(actor: "p1", card: .beer)
                    expect(result.queue) == [.heal(1, player: .actor).withCtx(ctx)]
                }
            }

            context("missing card") {
                it("should throw error") {
                    // Given
                    let state = GameState {
                        Player("p1")
                    }

                    // When
                    let action = GameAction.play(actor: "p1", card: .stagecoach)
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.thrownError) == .cardNotFound(.stagecoach)
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
                    expect(result.thrownError) == .playerNotFound("p1")
                }
            }

            context("not playable card") {
                it("should throw error") {
                    // Given
                    let state = GameState {
                        Player("p1") {
                            Hand {
                                .missed
                            }
                        }
                    }

                    // When
                    let action = GameAction.play(actor: "p1", card: .missed)
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.thrownError) == .cardIsNotPlayable(.missed)
                }
            }
        }
    }
}
