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
            context("and current turn") {
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

            context("not current turn") {
                it("should do nothing") {
                    // Given
                    let state = createGame {
                        Player("p1")
                        Player("p2")
                        Player("p3")
                    }
                    .ability(.nextTurnOnEliminated)
                    .turn("p2")

                    // When
                    let action = GameAction.eliminate("p3")
                    let result = self.awaitAction(action, state: state)

                    // Then
                    expect(result) == [
                        .success(.eliminate("p3"))
                    ]
                }
            }
        }
    }
}
