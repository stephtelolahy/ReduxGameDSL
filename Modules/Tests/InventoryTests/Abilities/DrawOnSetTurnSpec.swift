//
//  DrawOnSetTurnSpec.swift
//  
//
//  Created by Hugues Stephano TELOLAHY on 02/05/2023.
//

import Quick
import Nimble
import Game
import Inventory

final class DrawOnSetTurnSpec: QuickSpec {
    override func spec() {
        describe("starting turn") {
            context("a default player") {
                it("should draw 2 cards") {
                    // Given
                    let state = createGame {
                        Player("p1")
                            .abilities([.drawOnSetTurn])
                        Deck {
                            "c1"
                            "c2"
                        }
                    }
                        .event(.setTurn("p1"))
                    
                    // When
                    let action = GameAction.update
                    let result = self.awaitAction(action, state: state)
                    
                    // Then
                    expect(result) == [.success(.trigger(actor: "p1", card: .drawOnSetTurn)),
                                       .success(.draw(player: "p1")),
                                       .success(.draw(player: "p1"))]
                }
            }
            
            context("a player with 3 initial cards") {
                it("should draw 3 cards") {
                    // Given
                    let state = createGame {
                        Player("p1")
                            .abilities([.drawOnSetTurn])
                            .starTurnCards(3)
                        Deck {
                            "c1"
                            "c2"
                            "c3"
                        }
                    }
                        .event(.setTurn("p1"))
                    
                    // When
                    let action = GameAction.update
                    let result = self.awaitAction(action, state: state)
                    
                    // Then
                    expect(result) == [.success(.trigger(actor: "p1", card: .drawOnSetTurn)),
                                       .success(.draw(player: "p1")),
                                       .success(.draw(player: "p1")),
                                       .success(.draw(player: "p1"))]
                }
            }

            context("a player without ability") {
                it("should do nothing") {
                    // Given
                    let state = createGame {
                        Player("p1")
                    }
                        .event(.setTurn("p1"))

                    // When
                    let action = GameAction.update
                    let result = self.awaitAction(action, state: state)

                    // Then
                    expect(result).to(beEmpty())
                }
            }
        }
    }
}
