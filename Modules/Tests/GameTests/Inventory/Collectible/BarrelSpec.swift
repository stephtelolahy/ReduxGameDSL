//
//  BarrelTests.swift
//
//
//  Created by Hugues Telolahy on 18/06/2023.
//

import Quick
import Nimble
import Game

// TODO: FlipTwoCards_IfHavingAttribute

final class BarrelSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        describe("playing barrel") {
            it("should equip") {
                // Given
                let state = createGame {
                    Player("p1") {
                        Hand {
                            .barrel
                        }
                    }
                }
                
                // When
                let action = GameAction.play(.barrel, actor: "p1")
                let result = self.awaitAction(action, state: state)
                
                // Then
                expect(result) == [.success(.playEquipment(.barrel, actor: "p1"))]
            }
        }
        
        describe("triggering barrel") {
            context("flipped card is hearts") {
                it("should cancel shot") {
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
                            "c1-2♥️"
                        }
                    }
                    
                    // When
                    let action = GameAction.playImmediate(.bang, target: "p2", actor: "p1")
                    let result = self.awaitAction(action, state: state)
                    
                    // Then
                    expect(result) == [.success(.playImmediate(.bang, target: "p2", actor: "p1")),
                                       .success(.luck),
                                       .success(.cancel)]
                }
            }
            
            context("flipped card is spades") {
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
