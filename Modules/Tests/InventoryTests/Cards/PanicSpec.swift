//
//  PanicSpec.swift
//
//
//  Created by Hugues Telolahy on 15/04/2023.
//

import Quick
import Nimble
import Game
import Inventory

final class PanicSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        describe("playing Panic") {
            context("without target") {
                context("no player allowed") {
                    it("should throw error") {
                        // Given
                        let state = createGame {
                            Player("p1") {
                                Hand {
                                    .panic
                                }
                            }
                        }
                        let sut = createGameStore(initial: state)

                        // When
                        let action = GameAction.play(actor: "p1", card: .panic)
                        let result = self.awaitAction(action, store: sut)

                        // Then
                        expect(result) == [.failure(GameError.noPlayerWithCard)]
                    }
                }

                context("some player allowed") {
                    it("should choose a target that is at range 1") {
                        // Given
                        let state = createGame {
                            Player("p1") {
                                Hand {
                                    .panic
                                }
                            }
                            Player("p2") {
                                InPlay {
                                    "c2"
                                }
                            }
                            Player("p3") {
                                InPlay {
                                    "c3"
                                }
                            }
                            Player("p4") {
                                InPlay {
                                    "c4"
                                }
                            }
                        }
                        let sut = createGameStore(initial: state)

                        // When
                        let action = GameAction.play(actor: "p1", card: .panic)
                        let result = self.awaitAction(action, store: sut)

                        // Then
                        expect(result).to(beEmpty())
                        expect(sut.state.queue.first) == .chooseOne(chooser: "p1", options: [
                            "p2": .play(actor: "p1", card: .panic, target: "p2"),
                            "p4": .play(actor: "p1", card: .panic, target: "p4")
                        ])
                    }
                }
            }

            context("target is other") {
                context("without cards") {
                    it("should throw error") {
                        // Given
                        let state = createGame {
                            Player("p1") {
                                Hand {
                                    .panic
                                }
                            }
                            Player("p2")
                        }
                        let sut = createGameStore(initial: state)

                        // When
                        let action = GameAction.play(actor: "p1", card: .panic, target: "p2")
                        let result = self.awaitAction(action, store: sut)

                        // Then
                        expect(result) == [.success(.play(actor: "p1", card: .panic, target: "p2")),
                                           .failure(.playerHasNoCard("p2"))]
                    }
                }

                context("having hand cards") {
                    it("should choose one random hand card") {
                        // Given
                        let state = createGame {
                            Player("p1") {
                                Hand {
                                    .panic
                                }
                            }
                            Player("p2") {
                                Hand {
                                    "c21"
                                    "c22"
                                }
                            }
                        }
                        let sut = createGameStore(initial: state)

                        // When
                        let action = GameAction.play(actor: "p1", card: .panic, target: "p2")
                        let result = self.awaitAction(action, store: sut)

                        // Then
                        expect(result) == [.success(.play(actor: "p1", card: .panic, target: "p2"))]

                        guard case let .chooseOne(chooser, options) = sut.state.queue.first,
                              chooser == "p1",
                              options.count == 1,
                              let choice = options[.randomHand] else {
                            fail("Missing choice")
                            return
                        }

                        let ctx = EffectContext(actor: "p1", card: .panic, target: "p2")
                        let randomOptions: [GameAction] = [
                            .steal(player: .id("p1"), target: .id("p2"), card: .id("c21"), ctx: ctx),
                            .steal(player: .id("p1"), target: .id("p2"), card: .id("c22"), ctx: ctx)
                        ]
                        expect(randomOptions).to(contain(choice))
                    }
                }

                context("having inPlay cards") {
                    it("should choose one inPlay card") {
                        // Given
                        let state = createGame {
                            Player("p1") {
                                Hand {
                                    .panic
                                }
                            }
                            Player("p2") {
                                InPlay {
                                    "c21"
                                    "c22"
                                }
                            }
                        }
                        let sut = createGameStore(initial: state)

                        // When
                        let action = GameAction.play(actor: "p1", card: .panic, target: "p2")
                        let result = self.awaitAction(action, store: sut)

                        // Then
                        expect(result) == [.success(.play(actor: "p1", card: .panic, target: "p2"))]
                        let ctx = EffectContext(actor: "p1", card: .panic, target: "p2")
                        expect(sut.state.queue.first) == .chooseOne(chooser: "p1", options: [
                            "c21": .steal(player: .id("p1"), target: .id("p2"), card: .id("c21"), ctx: ctx),
                            "c22": .steal(player: .id("p1"), target: .id("p2"), card: .id("c22"), ctx: ctx)
                        ])
                    }
                }

                context("having hand and inPlay cards") {
                    it("should choose one inPlay or random hand card") {
                        // Given
                        let state = createGame {
                            Player("p1") {
                                Hand {
                                    .panic
                                }
                            }
                            Player("p2") {
                                Hand {
                                    "c21"
                                }
                                InPlay {
                                    "c22"
                                    "c23"
                                }
                            }
                        }
                        let sut = createGameStore(initial: state)

                        // When
                        let action = GameAction.play(actor: "p1", card: .panic, target: "p2")
                        let result = self.awaitAction(action, store: sut)

                        // Then
                        expect(result) == [.success(.play(actor: "p1", card: .panic, target: "p2"))]
                        let ctx = EffectContext(actor: "p1", card: .panic, target: "p2")
                        expect(sut.state.queue.first) == .chooseOne(chooser: "p1", options: [
                            "c22": .steal(player: .id("p1"), target: .id("p2"), card: .id("c22"), ctx: ctx),
                            "c23": .steal(player: .id("p1"), target: .id("p2"), card: .id("c23"), ctx: ctx),
                            .randomHand: .steal(player: .id("p1"), target: .id("p2"), card: .id("c21"), ctx: ctx)
                        ])
                    }
                }
            }

            xcontext("target is self") {
                it("should choose one inPlay card") {
                    // Given
                    // When
                    // Then
                }

                it("should not choose hand cards") {
                    // Given
                    // When
                    // Then
                }
            }
        }
    }
}
