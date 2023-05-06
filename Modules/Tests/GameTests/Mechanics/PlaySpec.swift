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
                    let playable = Card("playable") {
                        onPlay {
                            CardEffect.heal(1, player: .actor)
                        }
                    }
                    let state = GameState {
                        Player("p1") {
                            Hand {
                                "playable"
                            }
                        }
                    }
                    .cardRef(["playable": playable])
                    
                    // When
                    action = GameAction.play(actor: "p1", card: "playable")
                    result = sut.reduce(state: state, action: action)
                }

                it("should discard immediately") {
                    // Then
                    expect(result.player("p1").hand.cards).to(beEmpty())
                    expect(result.discard.top) == "playable"
                }

                it("should emit event") {
                    // Then
                    expect(result.event) == .play(actor: "p1", card: "playable")
                }

                it("should increment counter") {
                    // Then
                    expect(result.playCounter["playable"]) == 1
                }

                it("should queue side effects") {
                    // Then
                    let ctx = EffectContext(actor: "p1", card: "playable")
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
                    let action = GameAction.play(actor: "p1", card: "unknown")
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.error) == .cardNotFound("unknown")
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
                    expect(result.error) == .playerNotFound("p1")
                }
            }

            context("not playable card") {
                it("should throw error") {
                    // Given
                    let state = GameState {
                        Player("p1") {
                            Hand {
                                "unplayable"
                            }
                        }
                    }

                    // When
                    let action = GameAction.play(actor: "p1", card: "unplayable")
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.error) == .cardNotPlayable("unplayable")
                }
            }
        }
    }
}
