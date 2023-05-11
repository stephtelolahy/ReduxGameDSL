//
//  BangSpec.swift
//  
//
//  Created by Hugues Telolahy on 16/04/2023.
//

import Game
import Quick
import Nimble
import Inventory

final class BangSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        describe("playing bang") {
            context("reached limit per turn") {
                it("should throw error") {
                    // Given
                    let state = createGame {
                        Player("p1") {
                            Hand {
                                .bang
                            }
                        }
                    }
                        .counters([.bang: 1])
                    
                    // When
                    let action = GameAction.play(actor: "p1", card: .bang)
                    let result = self.awaitAction(action, state: state)
                    
                    // Assert
                    expect(result) == [.failure(.mismatched(.isTimesPerTurn(1)))]
                }
            }
            
            context("without target") {
                context("no player reachable") {
                    it("should throw error") {
                        // Given
                        let state = createGame {
                            Player("p1") {
                                Hand {
                                    .bang
                                }
                            }
                            Player("p2").attribute(.mustang, 1)
                            Player("p3")
                            Player("p4").attribute(.mustang, 1)
                        }
                        
                        // When
                        let action = GameAction.play(actor: "p1", card: .bang)
                        let result = self.awaitAction(action, state: state)
                        
                        // Then
                        expect(result) == [.failure(.noPlayer(.selectAt(1)))]
                    }
                }
                
                context("some player reachable") {
                    it("should choose a target") {
                        // Given
                        let state = createGame {
                            Player("p1") {
                                Hand {
                                    .bang
                                }
                            }
                            Player("p2")
                            Player("p3")
                            Player("p4")
                        }
                        
                        // When
                        let action = GameAction.play(actor: "p1", card: .bang)
                        let result = self.awaitAction(action, choices: ["p2", .pass], state: state)
                        
                        // Then
                        expect(result) == [
                            .success(.chooseAction(chooser: "p1", options: [
                                "p2": .play(actor: "p1", card: .bang, target: "p2"),
                                "p4": .play(actor: "p1", card: .bang, target: "p4")
                            ])),
                            .success(.play(actor: "p1", card: .bang, target: "p2")),
                            .success(.chooseAction(chooser: "p2", options: [
                                .pass: .damage(player: "p2", value: 1)
                            ])),
                            .success(.damage(player: "p2", value: 1))
                        ]
                    }
                }
            }
            
            context("with target") {
                context("having missed") {
                    it("should ask to counter or pass") {
                        // Given
                        let state = createGame {
                            Player("p1") {
                                Hand {
                                    .bang
                                }
                            }
                            Player("p2") {
                                Hand {
                                    .missed
                                }
                            }
                        }
                        
                        // When
                        let action = GameAction.play(actor: "p1", card: .bang, target: "p2")
                        let result = self.awaitAction(action, choices: [.missed], state: state)
                        
                        // Then
                        expect(result) == [
                            .success(.play(actor: "p1", card: .bang, target: "p2")),
                            .success(.chooseAction(chooser: "p2", options: [
                                .missed: .discard(player: "p2", card: .missed),
                                .pass: .damage(player: "p2", value: 1)
                            ])),
                            .success(.discard(player: "p2", card: .missed))
                        ]
                    }
                }
                
                context("not having missed") {
                    it("should ask to pass only") {
                        // Given
                        let state = createGame {
                            Player("p1") {
                                Hand {
                                    .bang
                                }
                            }
                            Player("p2")
                        }
                        
                        // When
                        let action = GameAction.play(actor: "p1", card: .bang, target: "p2")
                        let result = self.awaitAction(action, choices: [.pass], state: state)
                        
                        // Then
                        expect(result) == [
                            .success(.play(actor: "p1", card: .bang, target: "p2")),
                            .success(.chooseAction(chooser: "p2", options: [
                                .pass: .damage(player: "p2", value: 1)
                            ])),
                            .success(.damage(player: "p2", value: 1))
                        ]
                    }
                }
            }
        }
    }
}
