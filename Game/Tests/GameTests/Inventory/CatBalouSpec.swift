//
//  CatBalouSpec.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

import Quick
import Nimble
import Game

final class CatBalouSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        describe("playing catBalou") {
            context("without target") {
                context("no player allowed") {
                    it("should throw error") {
                        // Given
                        let state = GameState {
                            Player("p1") {
                                Hand {
                                    "catBalou-9♦️"
                                }
                            }
                        }
                        let store = createGameStore(initial: state)

                        // When
                        let action = GameAction.play(actor: "p1", card: "catBalou-9♦️")
                        let result = self.awaitAction(action, store: store)

                        // Then
                        expect(result) == [.failure(GameError.noPlayerAllowed)]
                    }
                }

                context("some player allowed") {
                    it("should choose a target") {
                        // Given
                        let state = GameState {
                            Player("p1") {
                                Hand {
                                    "catBalou-9♦️"
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
                        let store = createGameStore(initial: state)

                        // When
                        let action = GameAction.play(actor: "p1", card: "catBalou-9♦️")
                        let result = self.awaitAction(action, store: store)

                        // Then
                        expect(result).to(beEmpty())
                        let currState = store.state
                        expect(currState.chooseOne) == [
                            .play(actor: "p1", card: "catBalou-9♦️", target: "p2"),
                            .play(actor: "p1", card: "catBalou-9♦️", target: "p3")
                        ]
                    }
                }
            }

            context("target is other") {
                context("without cards") {
                    it("should throw error") {
                        // Given
                        let state = GameState {
                            Player("p1") {
                                Hand {
                                    "catBalou-9♦️"
                                }
                            }
                            Player("p2")
                        }
                        let store = createGameStore(initial: state)

                        // When
                        let action = GameAction.play(actor: "p1", card: "catBalou-9♦️", target: "p2")
                        let result = self.awaitAction(action, store: store)

                        // Then
                        expect(result) == [.success(.play(actor: "p1", card: "catBalou-9♦️", target: "p2")),
                                           .failure(.playerHasNoCard("p2"))]
                    }
                }

                context("having hand cards") {
                    it("should choose one random hand card") {
                        // TODO: random hand should be hidden as a choice
                        // Given
                        let state = GameState {
                            Player("p1") {
                                Hand {
                                    "catBalou-9♦️"
                                }
                            }
                            Player("p2") {
                                Hand {
                                    "c21"
                                    "c22"
                                }
                            }
                        }
                        let store = createGameStore(initial: state)

                        // When
                        let action = GameAction.play(actor: "p1", card: "catBalou-9♦️", target: "p2")
                        let result = self.awaitAction(action, store: store)

                        // Then
                        expect(result) == [.success(.play(actor: "p1", card: "catBalou-9♦️", target: "p2"))]
                        let currState = store.state
                        expect(currState.chooseOne?.count) == 1
                        let choice: GameAction = currState.chooseOne![0]
                        let randomOptions: [GameAction] = [
                            .apply(.discard(player: .id("p2"), card: .id("c21")), ctx: action.ctx()),
                            .apply(.discard(player: .id("p2"), card: .id("c22")), ctx: action.ctx())
                        ]
                        expect(randomOptions).to(contain(choice))
                    }
                }

                context("having inPlay cards") {
                    it("should choose one inPlay card") {
                        // Given
                        let state = GameState {
                            Player("p1") {
                                Hand {
                                    "catBalou-9♦️"
                                }
                            }
                            Player("p2") {
                                InPlay {
                                    "c21"
                                    "c22"
                                }
                            }
                        }
                        let store = createGameStore(initial: state)

                        // When
                        let action = GameAction.play(actor: "p1", card: "catBalou-9♦️", target: "p2")
                        let result = self.awaitAction(action, store: store)

                        // Then
                        expect(result) == [.success(.play(actor: "p1", card: "catBalou-9♦️", target: "p2"))]
                        let ctx = action.ctx()
                        let currState = store.state
                        expect(currState.chooseOne) == [
                            .apply(.discard(player: .id("p2"), card: .id("c21")), ctx: ctx),
                            .apply(.discard(player: .id("p2"), card: .id("c22")), ctx: ctx)
                        ]
                    }
                }

                context("having hand and inPlay cards") {
                    it("should choose one inPlay or random hand card") {
                        // Given
                        let state = GameState {
                            Player("p1") {
                                Hand {
                                    "catBalou-9♦️"
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
                        let store = createGameStore(initial: state)

                        // When
                        let action = GameAction.play(actor: "p1", card: "catBalou-9♦️", target: "p2")
                        let result = self.awaitAction(action, store: store)

                        // Then
                        expect(result) == [.success(.play(actor: "p1", card: "catBalou-9♦️", target: "p2"))]
                        let ctx = action.ctx()
                        let currState = store.state
                        expect(currState.chooseOne) == [
                            .apply(.discard(player: .id("p2"), card: .id("c22")), ctx: ctx),
                            .apply(.discard(player: .id("p2"), card: .id("c23")), ctx: ctx),
                            .apply(.discard(player: .id("p2"), card: .id("c21")), ctx: ctx)
                        ]
                    }
                }
            }

            xcontext("target is self") {
                it("should choose one inPlay card") {
                    // Given
                    // When
                    // Then
                }
            }
        }
    }
}
