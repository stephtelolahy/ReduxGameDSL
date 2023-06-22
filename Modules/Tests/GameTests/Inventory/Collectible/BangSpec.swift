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
                        Player("p2")
                    }
                        .counters([.bang: 1])
                    
                    // When
                    let action = GameAction.play(actor: "p1", card: .bang)
                    let result = self.awaitAction(action, state: state)
                    
                    // Assert
                    expect(result) == [.failure(.noReq(.isTimesPerTurn(1)))]
                }
            }

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
                    expect(result) == [.failure(.noPlayer(.selectReachable))]
                }
            }

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
                    let action = GameAction.play(actor: "p1", card: .bang)
                    let result = self.awaitAction(action, choices: ["p2", .missed], state: state)

                    // Then
                    expect(result) == [
                        .success(.chooseOne(chooser: "p1", options: [
                            "p2": .playImmediate(actor: "p1", card: .bang, target: "p2")
                        ])),
                        .success(.playImmediate(actor: "p1", card: .bang, target: "p2")),
                        .success(.chooseOne(chooser: "p2", options: [
                            .missed: .discard(.missed, player: "p2"),
                            .pass: .damage(1, player: "p2")
                        ])),
                        .success(.discard(.missed, player: "p2"))
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
                    let action = GameAction.play(actor: "p1", card: .bang)
                    let result = self.awaitAction(action, choices: ["p2", .pass], state: state)

                    // Then
                    expect(result) == [
                        .success(.chooseOne(chooser: "p1", options: [
                            "p2": .playImmediate(actor: "p1", card: .bang, target: "p2")
                        ])),
                        .success(.playImmediate(actor: "p1", card: .bang, target: "p2")),
                        .success(.chooseOne(chooser: "p2", options: [
                            .pass: .damage(1, player: "p2")
                        ])),
                        .success(.damage(1, player: "p2"))
                    ]
                }
            }
        }
    }
}
