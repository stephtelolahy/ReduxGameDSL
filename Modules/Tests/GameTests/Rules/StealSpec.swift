//
//  StealSpec.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

@testable import Game
import Quick
import Nimble

final class StealSpec: QuickSpec {
    override func spec() {
        let sut = GameReducer()
        let ctx = EffectContext(actor: "p1", card: "cx")

        describe("steal") {
            context("hand card") {
                it("should remove card from hand") {
                    // Given
                    let state = GameState {
                        Player("p1")
                        Player("p2") {
                            Hand {
                                "c21"
                                "c22"
                            }
                        }
                    }

                    // When
                    let action = GameAction.steal(player: .id("p1"),
                                                  target: .id("p2"),
                                                  card: .id("c21"),
                                                  ctx: ctx)
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.player("p1").hand.cards) == ["c21"]
                    expect(result.player("p2").hand.cards) == ["c22"]
                }
            }

            context("inPlay card") {
                it("should remove card from inPlay") {
                    // Given
                    let state = GameState {
                        Player("p1")
                        Player("p2") {
                            InPlay {
                                "c21"
                                "c22"
                            }
                        }
                    }

                    // When
                    let action = GameAction.steal(player: .id("p1"),
                                                  target: .id("p2"),
                                                  card: .id("c21"),
                                                  ctx: ctx)
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.player("p1").hand.cards) == ["c21"]
                    expect(result.player("p2").inPlay.cards) == ["c22"]
                }
            }

            context("missing card") {
                it("should throw error") {
                    let state = GameState {
                        Player("p1")
                        Player("p2")
                    }

                    // When
                    let action = GameAction.steal(player: .id("p1"),
                                                  target: .id("p1"),
                                                  card: .id("c2"),
                                                  ctx: ctx)
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.thrownError) == GameError.cardNotFound("c2")
                }
            }
        }
    }
}
