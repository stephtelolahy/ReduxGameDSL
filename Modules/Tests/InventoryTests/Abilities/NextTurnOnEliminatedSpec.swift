//
//  NextTurnOnEliminatedSpec.swift
//  
//
//  Created by Hugues Telolahy on 16/05/2023.
//

import Quick
import Nimble
import Game
import Inventory

final class NextTurnOnEliminatedSpec: QuickSpec {
    override func spec() {
        describe("being eliminated") {
            context("current turn") {
                it("should next turn") {
                    // Given
                    let state = createGame {
                        Player("p1")
                        Player("p2")
                        Player("p3")
                    }
                    .ability(.nextTurnOnEliminated)
                    .turn("p3")

                    // When
                    let action = GameAction.eliminate("p3")
                    let result = self.awaitAction(action, state: state)

                    // Then
                    expect(result) == [
                        .success(.eliminate("p3")),
                        .success(.setTurn("p1"))
                    ]
                }
            }
            
            context("current turn and having cards") {
                it("should discard cards before setting next turn") {
                    // Given
                    let state = createGame {
                        Player("p1")
                        Player("p2")
                        Player("p3") {
                            Hand {
                                "c1"
                            }
                            InPlay {
                                "c2"
                            }
                        }
                    }
                    .ability(.discardCardsOnEliminated)
                    .ability(.nextTurnOnEliminated)
                    .turn("p3")

                    // When
                    let action = GameAction.eliminate("p3")
                    let result = self.awaitAction(action, state: state)

                    // Then
                    expect(result) == [
                        .success(.eliminate("p3")),
                        .success(.discard(player: "p3", card: "c2")),
                        .success(.discard(player: "p3", card: "c1")),
                        .success(.setTurn("p1"))
                    ]
                }
            }
        }
    }
}
