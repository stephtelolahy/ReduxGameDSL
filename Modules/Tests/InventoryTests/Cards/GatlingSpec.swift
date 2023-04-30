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
                    let action = GameAction.play(actor: "p1", card: .gatling)
                        let result = self.awaitAction(action, choices: [.missed, .pass], state: state)
                    
                    // Then
                    expect(result) == [
                        .success(.play(actor: "p1", card: .gatling)),
                        .success(.discard(player: "p2", card: .missed)),
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
                    let action = GameAction.play(actor: "p1", card: .gatling)
                        let result = self.awaitAction(action, choices: [.missed], state: state)
                    
                    // Then
                    expect(result) == [
                        .success(.play(actor: "p1", card: .gatling)),
                        .success(.discard(player: "p2", card: .missed))
                    ]
                }
            }
        }
    }
}
