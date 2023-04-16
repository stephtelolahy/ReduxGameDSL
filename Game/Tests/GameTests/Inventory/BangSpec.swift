//
//  BangSpec.swift
//  
//
//  Created by Hugues Telolahy on 16/04/2023.
//

import Game
import Quick
import Nimble

final class BangSpec: QuickSpec {
    override func spec() {
        describe("playing bang") {
            context("reached limit per turn") {
                // Given
                it("should throw error") {
                    let state = GameState {
                        Player("p1") {
                            Hand {
                                .bang
                            }
                        }

                    }.counterBang(1)

                    let sut = createGameStore(initial: state)

                    // When
                    let action = GameAction.play(actor: "p1", card: .bang)
                    let result = self.awaitAction(action, store: sut)

                    // Assert
                    expect(result) == [.failure(.reachedBangLimitPerTurn)]
                }
            }

            context("without target") {
                context("no player reachable") {
                    it("should throw error") {
                        // Given
                        let state = GameState {
                            Player("p1") {
                                Hand {
                                    .bang
                                }
                            }
                        }
                        let sut = createGameStore(initial: state)

                        // When
                        let action = GameAction.play(actor: "p1", card: .catBalou)
                        let result = self.awaitAction(action, store: sut)

                        // Then
                        expect(result) == [.failure(GameError.noPlayerWithCard)]
                    }
                }

                context("some player reachable") {
                    it("should choose a target") {
                        // Given
                        let state = GameState {
                            Player("p1") {
                                Hand {
                                    .bang
                                }
                            }
                            Player("p2")
                            Player("p3")
                            Player("p4")
                        }
                        let sut = createGameStore(initial: state)

                        // When
                        let action = GameAction.play(actor: "p1", card: .catBalou)
                        let result = self.awaitAction(action, store: sut)

                        // Then
                        expect(result).to(beEmpty())
                        expect(sut.state.chooseOne) == [
                            "p2": .play(actor: "p1", card: .catBalou, target: "p2"),
                            "p4": .play(actor: "p1", card: .catBalou, target: "p4")
                        ]
                    }
                }
            }

            context("with target") {
                context("having missed") {
                    it("should ask to counter") {
                    }
                }

                context("not having missed") {
                    it("should deal damage") {
                    }
                }
            }
        }
    }
}
