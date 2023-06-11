//
//  GatlingSpec.swift
//  
//
//  Created by Hugues Telolahy on 22/04/2023.
//

import Quick
import Nimble
import Game
import Inventory

final class GatlingSpec: QuickSpec {
    override func spec() {
        describe("playing gatling") {
            context("three players") {
                it("should allow each player to counter or pass") {
                    // Given
                    let state = createGame {
                        Player("p1") {
                            Hand {
                                .gatling
                            }
                        }
                        Player("p2") {
                            Hand {
                                .missed
                            }
                        }
                        
                        Player("p3")
                    }
                    
                    // When
                    let action = GameAction.move(actor: "p1", card: .gatling)
                    let result = self.awaitAction(action, choices: [.missed, .pass], state: state)
                    
                    // Then
                    expect(result) == [
                        .success(.playImmediate(actor: "p1", card: .gatling)),
                        .success(.chooseOne(chooser: "p2", options: [
                            .missed: .discard(player: "p2", card: .missed),
                            .pass: .damage(player: "p2", value: 1)
                        ])),
                        .success(.discard(player: "p2", card: .missed)),
                        .success(.chooseOne(chooser: "p3", options: [
                            .pass: .damage(player: "p3", value: 1)
                        ])),
                        .success(.damage(player: "p3", value: 1))
                    ]
                }
            }
            
            context("two players") {
                it("should allow each player to counter") {
                    // Given
                    let state = createGame {
                        Player("p1") {
                            Hand {
                                .gatling
                            }
                        }
                        Player("p2") {
                            Hand {
                                .missed
                            }
                        }
                    }
                    
                    // When
                    let action = GameAction.move(actor: "p1", card: .gatling)
                    let result = self.awaitAction(action, choices: [.missed], state: state)
                    
                    // Then
                    expect(result) == [
                        .success(.playImmediate(actor: "p1", card: .gatling)),
                        .success(.chooseOne(chooser: "p2", options: [
                            .missed: .discard(player: "p2", card: .missed),
                            .pass: .damage(player: "p2", value: 1)
                        ])),
                        .success(.discard(player: "p2", card: .missed))
                    ]
                }
            }
        }
    }
}
