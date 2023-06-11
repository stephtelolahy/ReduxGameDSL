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

                    // When
                    let action = GameAction.play(actor: "p1", card: .panic)
                    let result = self.awaitAction(action, state: state)

                    // Then
                    expect(result) == [.failure(.noPlayer(.selectAtRangeWithCard(1)))]
                }
            }
            
            context("target is other") {
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
                                }
                            }
                        }
                        
                        // When
                        let action = GameAction.play(actor: "p1", card: .panic)
                        let result = self.awaitAction(action, choices: ["p2", .randomHand], state: state)
                        
                        // Then
                        expect(result) == [
                            .success(.chooseOne(chooser: "p1", options: [
                                "p2": .playImmediate(actor: "p1", card: .panic, target: "p2")
                            ])),
                            .success(.playImmediate(actor: "p1", card: .panic, target: "p2")),
                            .success(.chooseOne(chooser: "p1", options: [
                                .randomHand: .steal(player: "p1", target: "p2", card: "c21")
                            ])),
                            .success(.steal(player: "p1", target: "p2", card: "c21"))
                        ]
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
                        
                        // When
                        let action = GameAction.play(actor: "p1", card: .panic)
                        let result = self.awaitAction(action, choices: ["p2", "c22"], state: state)
                        
                        // Then
                        expect(result) == [
                            .success(.chooseOne(chooser: "p1", options: [
                                "p2": .playImmediate(actor: "p1", card: .panic, target: "p2")
                            ])),
                            .success(.playImmediate(actor: "p1", card: .panic, target: "p2")),
                            .success(.chooseOne(chooser: "p1", options: [
                                "c21": .steal(player: "p1", target: "p2", card: "c21"),
                                "c22": .steal(player: "p1", target: "p2", card: "c22")
                            ])),
                            .success(.steal(player: "p1", target: "p2", card: "c22"))
                        ]
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
                        
                        // When
                        let action = GameAction.play(actor: "p1", card: .panic)
                        let result = self.awaitAction(action, choices: ["p2", "c23"], state: state)
                        
                        // Then
                        expect(result) == [
                            .success(.chooseOne(chooser: "p1", options: [
                                "p2": .playImmediate(actor: "p1", card: .panic, target: "p2")
                            ])),
                            .success(.playImmediate(actor: "p1", card: .panic, target: "p2")),
                            .success(.chooseOne(chooser: "p1", options: [
                                .randomHand: .steal(player: "p1", target: "p2", card: "c21"),
                                "c22": .steal(player: "p1", target: "p2", card: "c22"),
                                "c23": .steal(player: "p1", target: "p2", card: "c23")
                            ])),
                            .success(.steal(player: "p1", target: "p2", card: "c23"))
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
                
                it("should not choose hand cards") {
                    // Given
                    // When
                    // Then
                }
            }
        }
    }
}
