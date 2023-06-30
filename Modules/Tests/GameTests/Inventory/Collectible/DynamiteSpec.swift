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
                    .ability(.drawOnSetTurn)
                    
                    // When
                    let action = GameAction.setTurn("p1")
                    let result = self.awaitAction(action, state: state)
                    
                    // Then
                    expect(result) == [.success(.setTurn("p1")),
                                       .success(.luck),
                                       .success(.passInplay(.dynamite, target: "p2", player: "p1")),
                                       .success(.draw(player: "p1")),
                                       .success(.draw(player: "p1"))]
                }
            }
            
            context("flipped card is spades") {
                context("not lethal") {
                    it("should apply damage and discard card") {
                        // Given
                        let state = createGame {
                            Player("p1") {
                                InPlay {
                                    .dynamite
                                }
                            }
                            .attribute(.health, 4)
                            Deck {
                                "c1-8♠️"
                                "c2"
                                "c2"
                            }
                        }
                        .ability(.drawOnSetTurn)
                        
                        // When
                        let action = GameAction.setTurn("p1")
                        let result = self.awaitAction(action, state: state)
                        
                        // Then
                        expect(result) == [.success(.setTurn("p1")),
                                           .success(.luck),
                                           .success(.damage(3, player: "p1")),
                                           .success(.discard("dynamite", player: "p1")),
                                           .success(.draw(player: "p1")),
                                           .success(.draw(player: "p1"))]
                    }
                }
                
                context("lethal") {
                    it("should eliminate") {
                        // Given
                        let state = createGame {
                            Player("p1") {
                                InPlay {
                                    .dynamite
                                }
                            }
                            .attribute(.health, 3)
                            Player("p2")
                            Player("p3")
                            Deck {
                                "c1-8♠️"
                                "c2"
                                "c2"
                            }
                        }
                        .ability(.eliminateOnLooseLastHealth)
                        .ability(.nextTurnOnEliminated)
                        .ability(.drawOnSetTurn)
                        // TODO: discard all cards on eliminated
                        
                        // When
                        let action = GameAction.setTurn("p1")
                        let result = self.awaitAction(action, state: state)
                        
                        // Then
                        expect(result) == [.success(.setTurn("p1")),
                                           .success(.luck),
                                           .success(.damage(3, player: "p1")),
                                           .success(.eliminate(player: "p1")),
                                           .success(.setTurn("p2")),
                                           .success(.draw(player: "p2")),
                                           .success(.draw(player: "p2"))]
                    }
                }
            }
        }
    }
}
