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
                        
                        // When
                        let action = GameAction.play(actor: "p1", card: .panic)
                        let result = self.awaitAction(action, state: state)
                        
                        // Then
                        expect(result) == [.failure(.noPlayer(.selectAtRangeWithCard(1)))]
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
                        
                        // When
                        let action = GameAction.play(actor: "p1", card: .panic)
                        let result = self.awaitAction(action, choices: ["p2", "c2"], state: state)
                        
                        // Then
                        expect(result) == [
                            .success(.chooseAction(chooser: "p1", options: [
                                "p2": .play(actor: "p1", card: .panic, target: "p2"),
                                "p4": .play(actor: "p1", card: .panic, target: "p4")
                            ])),
                            .success(.play(actor: "p1", card: .panic, target: "p2")),
                            .success(.chooseAction(chooser: "p1", options: [
                                "c2": .steal(player: "p1", target: "p2", card: "c2")
                            ])),
                            .success(.steal(player: "p1", target: "p2", card: "c2"))
                        ]
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
                        
                        // When
                        let action = GameAction.play(actor: "p1", card: .panic, target: "p2")
                        let result = self.awaitAction(action, state: state)
                        
                        // Then
                        expect(result) == [
                            .success(.play(actor: "p1", card: .panic, target: "p2")),
                            .failure(.noCard(.selectAny))
                        ]
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
                                }
                            }
                        }
                        
                        // When
                        let action = GameAction.play(actor: "p1", card: .panic, target: "p2")
                        let result = self.awaitAction(action, choices: [.randomHand], state: state)
                        
                        // Then
                        expect(result) == [
                            .success(.play(actor: "p1", card: .panic, target: "p2")),
                            .success(.chooseAction(chooser: "p1", options: [
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
                        let action = GameAction.play(actor: "p1", card: .panic, target: "p2")
                        let result = self.awaitAction(action, choices: ["c22"], state: state)
                        
                        // Then
                        expect(result) == [
                            .success(.play(actor: "p1", card: .panic, target: "p2")),
                            .success(.chooseAction(chooser: "p1", options: [
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
                        let action = GameAction.play(actor: "p1", card: .panic, target: "p2")
                        let result = self.awaitAction(action, choices: ["c23"], state: state)
                        
                        // Then
                        expect(result) == [
                            .success(.play(actor: "p1", card: .panic, target: "p2")),
                            .success(.chooseAction(chooser: "p1", options: [
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
