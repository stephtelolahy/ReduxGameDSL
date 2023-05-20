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
                        
                        // When
                        let action = GameAction.move(actor: "p1", card: .catBalou)
                        let result = self.awaitAction(action, state: state)
                        
                        // Then
                        expect(result) == [.failure(.noPlayer(.selectAnyWithCard))]
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
                        
                        // When
                        let action = GameAction.move(actor: "p1", card: .catBalou)
                        let result = self.awaitAction(action, choices: ["p2", .randomHand], state: state)
                        
                        // Then
                        expect(result) == [
                            .success(.chooseOne(chooser: "p1", options: [
                                "p2": .play(actor: "p1", card: .catBalou, target: "p2"),
                                "p3": .play(actor: "p1", card: .catBalou, target: "p3")
                            ])),
                            .success(.play(actor: "p1", card: .catBalou, target: "p2")),
                            .success(.chooseOne(chooser: "p1", options: [
                                .randomHand: .discard(player: "p2", card: "c2")
                            ])),
                            .success(.discard(player: "p2", card: "c2"))
                        ]
                    }
                }
            }
            
            context("target is other") {
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
                                }
                            }
                        }
                        
                        // When
                        let action = GameAction.play(actor: "p1", card: .catBalou, target: "p2")
                        let result = self.awaitAction(action, choices: [.randomHand], state: state)
                        
                        // Then
                        expect(result) == [
                            .success(.play(actor: "p1", card: .catBalou, target: "p2")),
                            .success(.chooseOne(chooser: "p1", options: [
                                .randomHand: .discard(player: "p2", card: "c21")
                            ])),
                            .success(.discard(player: "p2", card: "c21"))
                        ]
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
                        
                        // When
                        let action = GameAction.play(actor: "p1", card: .catBalou, target: "p2")
                        let result = self.awaitAction(action, choices: ["c22"], state: state)
                        
                        // Then
                        expect(result) == [
                            .success(.play(actor: "p1", card: .catBalou, target: "p2")),
                            .success(.chooseOne(chooser: "p1", options: [
                                "c21": .discard(player: "p2", card: "c21"),
                                "c22": .discard(player: "p2", card: "c22")
                            ])),
                            .success(.discard(player: "p2", card: "c22"))
                        ]
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
                        
                        // When
                        let action = GameAction.play(actor: "p1", card: .catBalou, target: "p2")
                        let result = self.awaitAction(action, choices: ["c23"], state: state)
                        
                        // Then
                        expect(result) == [
                            .success(.play(actor: "p1", card: .catBalou, target: "p2")),
                            .success(.chooseOne(chooser: "p1", options: [
                                .randomHand: .discard(player: "p2", card: "c21"),
                                "c22": .discard(player: "p2", card: "c22"),
                                "c23": .discard(player: "p2", card: "c23")
                            ])),
                            .success(.discard(player: "p2", card: "c23"))
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
