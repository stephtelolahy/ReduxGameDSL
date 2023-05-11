//
//  IndiansSpec.swift
//  
//
//  Created by Hugues Telolahy on 22/04/2023.
//

import Quick
import Nimble
import Game
import Inventory

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
                        .success(.play(actor: "p1", card: .indians)),
                        .success(.chooseAction(chooser: "p2", options: [
                            .bang: .discard(player: "p2", card: .bang),
                            .pass: .damage(player: "p2", value: 1)
                        ])),
                        .success(.discard(player: "p2", card: .bang)),
                        .success(.chooseAction(chooser: "p3", options: [
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
                        .success(.play(actor: "p1", card: .indians)),
                        .success(.chooseAction(chooser: "p2", options: [
                            .bang: .discard(player: "p2", card: .bang),
                            .pass: .damage(player: "p2", value: 1)
                        ])),
                        .success(.discard(player: "p2", card: .bang))
                    ]
                }
            }
        }
    }
}
