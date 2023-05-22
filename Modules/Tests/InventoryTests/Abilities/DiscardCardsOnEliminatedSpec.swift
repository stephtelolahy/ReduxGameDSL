//
//  DiscardCardsOnEliminatedSpec.swift
//  
//
//  Created by Hugues Telolahy on 18/05/2023.
//

import Quick
import Nimble
import Game
import Inventory

final class DiscardCardsOnEliminatedSpec: QuickSpec {
    override func spec() {
        describe("being eliminated") {
            context("having cards") {
                it("should discard cards") {
                    // Given
                    let state = createGame {
                        Player("p1") {
                            Hand {
                                "c1"
                            }
                            InPlay {
                                "c2"
                            }
                        }
                    }
                    .ability(.discardCardsOnEliminated)

                    // When
                    let action = GameAction.eliminate("p1")
                    let result = self.awaitAction(action, state: state)

                    // Then
                    expect(result) == [
                        .success(.eliminate("p1")),
                        .success(.discard(player: "p1", card: "c2")),
                        .success(.discard(player: "p1", card: "c1"))
                    ]
                }
            }
        }
    }
}
