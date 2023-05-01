//
//  EndTurnSpec.swift
//  
//
//  Created by Hugues Telolahy on 01/05/2023.
//

import Quick
import Nimble
import Game
import Inventory

final class EndTurnSpec: QuickSpec {
    override func spec() {
        describe("ending turn") {
            context("no excess cards") {
                it("should discard nothing") {
                    // Given
                    let state = createGame {
                        Player("p1")
                        Player("p2")
                    }
                    .turn("p1")

                    // When
                    let action = GameAction.invoke(actor: "p1", card: .endTurn)
                    let result = self.awaitAction(action, state: state)

                    // Then
                    expect(result) == [
                        .success(.invoke(actor: "p1", card: .endTurn)),
                        .success(.setTurn("p2"))
                    ]
                }
            }

            xcontext("1 excess card") {
                it("should discard a card") {
                    // Given
                    // When
                    // Then
                }
            }

            xcontext("2 excess cards") {
                it("should discard 2 cards") {
                    // Given
                    // When
                    // Then
                }
            }
        }
    }
}
