//
//  IndiansSpec.swift
//  
//
//  Created by Hugues Telolahy on 22/04/2023.
//

import Quick
import Nimble
import Game

final class IndiansSpec: QuickSpec {
    override func spec() {
        describe("playing Indians") {
            context("three players") {
                it("should allow each player to counter or pass") {
                    // Given
                    let state = createGame {
                        Player("p1") {
                            Hand {
                                .indians
                            }
                        }
                        Player("p2") {
                            Hand {
                                String.bang
                                String.missed
                            }
                        }
                        
                        Player("p3")
                    }
                    
                    // When
                    let action = GameAction.play(actor: "p1", card: .indians)
                    let result = self.awaitAction(action, choices: [.bang, .pass], state: state)
                    
                    // Then
                    expect(result) == [
                        .success(.playImmediate(actor: "p1", card: .indians)),
                        .success(.chooseOne(chooser: "p2", options: [
                            .bang: .discard(.bang, player: "p2"),
                            .pass: .damage(1, player: "p2")
                        ])),
                        .success(.discard(.bang, player: "p2")),
                        .success(.chooseOne(chooser: "p3", options: [
                            .pass: .damage(1, player: "p3")
                        ])),
                        .success(.damage(1, player: "p3"))
                    ]
                }
            }
            
            context("two players") {
                it("should allow each player to counter") {
                    // Given
                    let state = createGame {
                        Player("p1") {
                            Hand {
                                .indians
                            }
                        }
                        Player("p2") {
                            Hand {
                                .bang
                            }
                        }
                    }
                    
                    // When
                    let action = GameAction.play(actor: "p1", card: .indians)
                    let result = self.awaitAction(action, choices: [.bang], state: state)
                    
                    // Then
                    expect(result) == [
                        .success(.playImmediate(actor: "p1", card: .indians)),
                        .success(.chooseOne(chooser: "p2", options: [
                            .bang: .discard(.bang, player: "p2"),
                            .pass: .damage(1, player: "p2")
                        ])),
                        .success(.discard(.bang, player: "p2"))
                    ]
                }
            }
        }
    }
}
