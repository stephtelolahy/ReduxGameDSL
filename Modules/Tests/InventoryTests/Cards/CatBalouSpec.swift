//
//  CatBalouSpec.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

import Quick
import Nimble
import Game
import Inventory

final class CatBalouSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        describe("playing catBalou") {
            context("without target") {
                context("no player allowed") {
                    it("should throw error") {
                        // Given
                        let state = createGame {
                            Player("p1") {
                                Hand {
                                    .catBalou
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

                context("some player allowed") {
                    it("should choose a target") {
                        // Given
                        let state = createGame {
                            Player("p1") {
                                Hand {
                                    .catBalou
                                }
                            }
                            Player("p2") {
                                Hand {
                                    "c2"
                                }
                            }
                            Player("p3") {
                                InPlay {
                                    "c3"
                                }
                            }
                        }
                        let sut = createGameStore(initial: state)

                        // When
                        let action = GameAction.play(actor: "p1", card: .catBalou)
                        let result = self.awaitAction(action, store: sut)

                        // Then
                        expect(result).to(beEmpty())
                        expect(sut.state.chooseOne) == ChooseOne(chooser: "p1", options: [
                            "p2": .play(actor: "p1", card: .catBalou, target: "p2"),
                            "p3": .play(actor: "p1", card: .catBalou, target: "p3")
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
                                    .catBalou
                                }
                            }
                            Player("p2")
                        }
                        let sut = createGameStore(initial: state)

                        // When
                        let action = GameAction.play(actor: "p1", card: .catBalou, target: "p2")
                        let result = self.awaitAction(action, store: sut)

                        // Then
                        expect(result) == [.success(.play(actor: "p1", card: .catBalou, target: "p2")),
                                           .failure(.playerHasNoCard("p2"))]
                    }
                }

                context("having hand cards") {
                    it("should choose one random hand card") {
                        // Given
                        let state = createGame {
                            Player("p1") {
                                Hand {
                                    .catBalou
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
                        let action = GameAction.play(actor: "p1", card: .catBalou, target: "p2")
                        let result = self.awaitAction(action, store: sut)

                        // Then
                        expect(result) == [.success(.play(actor: "p1", card: .catBalou, target: "p2"))]
                        guard let chooseOne = sut.state.chooseOne,
                              chooseOne.chooser == "p1",
                              chooseOne.options.count == 1,
                              let choice = chooseOne.options[.randomHand] else {
                            fail("Missing choice")
                            return
                        }
                        let ctx = EffectContext(actor: "p1", card: .catBalou, target: "p2")
                        let randomOptions: [GameAction] = [
                            .discard(player: .id("p2"), card: .id("c21"), ctx: ctx),
                            .discard(player: .id("p2"), card: .id("c22"), ctx: ctx)
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
                                    .catBalou
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
                        let action = GameAction.play(actor: "p1", card: .catBalou, target: "p2")
                        let result = self.awaitAction(action, store: sut)

                        // Then
                        expect(result) == [.success(.play(actor: "p1", card: .catBalou, target: "p2"))]
                        let ctx = EffectContext(actor: "p1", card: .catBalou, target: "p2")
                        expect(sut.state.chooseOne) == ChooseOne(chooser: "p1", options: [
                            "c21": .discard(player: .id("p2"), card: .id("c21"), ctx: ctx),
                            "c22": .discard(player: .id("p2"), card: .id("c22"), ctx: ctx)
                        ])
                        
                        // TODO: 
                        expect(sut.state.chooseOne) == nil
                    }
                }

                context("having hand and inPlay cards") {
                    it("should choose one inPlay or random hand card") {
                        // Given
                        let state = createGame {
                            Player("p1") {
                                Hand {
                                    .catBalou
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
                        let action = GameAction.play(actor: "p1", card: .catBalou, target: "p2")
                        let result = self.awaitAction(action, store: sut)

                        // Then
                        expect(result) == [.success(.play(actor: "p1", card: .catBalou, target: "p2"))]
                        let ctx = EffectContext(actor: "p1", card: .catBalou, target: "p2")
                        expect(sut.state.chooseOne) == ChooseOne(chooser: "p1", options: [
                            "c22": .discard(player: .id("p2"), card: .id("c22"), ctx: ctx),
                            "c23": .discard(player: .id("p2"), card: .id("c23"), ctx: ctx),
                            .randomHand: .discard(player: .id("p2"), card: .id("c21"), ctx: ctx)
                        ])
                        
                        // TODO: 
                        expect(sut.state.chooseOne) == nil
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
