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
                let action = GameAction.play(actor: "p1", card: .barrel)
                let result = self.awaitAction(action, state: state)
                
                // Then
                expect(result) == [.success(.playEquipment(actor: "p1", card: .barrel))]
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
                    let action = GameAction.playImmediate(actor: "p1", card: .bang, target: "p2")
                    let result = self.awaitAction(action, state: state)
                    
                    // Then
                    expect(result) == [.success(.playImmediate(actor: "p1", card: .bang, target: "p2")),
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
                    let action = GameAction.playImmediate(actor: "p1", card: .bang, target: "p2")
                    let result = self.awaitAction(action, choices: [.pass], state: state)
                    
                    // Then
                    expect(result) == [.success(.playImmediate(actor: "p1", card: .bang, target: "p2")),
                                       .success(.luck),
                                       .success(.chooseOne(chooser: "p2", options: [
                                        .pass: .damage(player: "p2", value: 1)
                                       ])),
                                       .success(.damage(player: "p2", value: 1))]
                }
            }
        }
    }
}
