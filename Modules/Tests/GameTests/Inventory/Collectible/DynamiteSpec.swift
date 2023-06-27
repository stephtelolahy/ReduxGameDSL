//
//  DynamiteSpec.swift
//  
//
//  Created by Hugues Stephano TELOLAHY on 26/06/2023.
//

import Quick
import Nimble
import Game

final class DynamiteSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        describe("playing dynamite") {
            it("should target") {
                // Given
                let state = createGame {
                    Player("p1") {
                        Hand {
                            .dynamite
                        }
                    }
                }
                
                // When
                let action = GameAction.play(.dynamite, actor: "p1")
                let result = self.awaitAction(action, state: state)
                
                // Then
                expect(result) == [
                    .success(.playEquipment(.dynamite, actor: "p1"))
                ]
            }
        }
        
        describe("triggering dynamite") {
            context("flipped card is hearts") {
                it("should pass inPlay") {
                    // Given
                    let state = createGame {
                        Player("p1") {
                            InPlay {
                                .dynamite
                            }
                        }
                        Player("p2")
                        Deck {
                            "c1-9♦️"
                            "c2"
                            "c3"
                        }
                    }
                    
                    // When
                    let action = GameAction.setTurn("p1")
                    let result = self.awaitAction(action, state: state)
                    
                    // Then
                    expect(result) == [.success(.setTurn("p1")),
                                       .success(.luck),
                                       .success(.passInplay(.dynamite, target: "p2", player: "p1"))]
                }
            }
            
            xcontext("flipped card is spades") {
                it("should apply damage") {
                    // Given
                    let state = createGame {
                        Player("p1") {
                            Hand {
                                .bang
                            }
                        }
                        Player("p2") {
                            InPlay {
                                .barrel
                            }
                        }
                        Deck {
                            "c1-A♠️"
                        }
                    }
                    
                    // When
                    let action = GameAction.playImmediate(.bang, target: "p2", actor: "p1")
                    let result = self.awaitAction(action, choices: [.pass], state: state)
                    
                    // Then
                    expect(result) == [.success(.playImmediate(.bang, target: "p2", actor: "p1")),
                                       .success(.luck),
                                       .success(.chooseOne(player: "p2", options: [
                                        .pass: .damage(1, player: "p2")
                                       ])),
                                       .success(.damage(1, player: "p2"))]
                }
            }
        }
    }
}

