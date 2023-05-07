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
        let ctx = EffectContext(actor: "px", card: "cx")

        describe("starting turn") {
            context("a player with 2 initial cards") {
                it("should draw 2 cards") {
                    // Given
                    let state = createGame {
                        Player("p1")
                        Player("p2")
                        Deck {
                            "c1"
                            "c2"
                        }
                    }
                    .ability(.drawOnSetTurn)
                    
                    // When
                    let action = GameAction.effect(.setTurn(.id("p1")), ctx: ctx)
                    let result = self.awaitAction(action, state: state)
                    
                    // Then
                    expect(result) == [
                        .success(.setTurn("p1")),
                        .success(.forcePlay(actor: "p1", card: .drawOnSetTurn)),
                        .success(.draw(player: "p1")),
                        .success(.draw(player: "p1"))
                    ]
                }
            }
            
            context("a player with 3 initial cards") {
                it("should draw 3 cards") {
                    // Given
                    let state = createGame {
                        Player("p1")
                            .attribute(.starTurnCards, 3)
                        Player("p2")
                        Deck {
                            "c1"
                            "c2"
                            "c3"
                        }
                    }
                    .ability(.drawOnSetTurn)

                    // When
                    let action = GameAction.effect(.setTurn(.id("p1")), ctx: ctx)
                    let result = self.awaitAction(action, state: state)
                    
                    // Then
                    expect(result) == [
                        .success(.setTurn("p1")),
                        .success(.forcePlay(actor: "p1", card: .drawOnSetTurn)),
                        .success(.draw(player: "p1")),
                        .success(.draw(player: "p1")),
                        .success(.draw(player: "p1"))
                    ]
                }
            }

            context("a player without ability") {
                it("should do nothing") {
                    // Given
                    let state = createGame {
                        Player("p1")
                    }

                    // When
                    let action = GameAction.effect(.setTurn(.id("p1")), ctx: ctx)
                    let result = self.awaitAction(action, state: state)

                    // Then
                    expect(result) == [
                        .success(.setTurn("p1"))
                    ]
                }
            }
        }
    }
}
