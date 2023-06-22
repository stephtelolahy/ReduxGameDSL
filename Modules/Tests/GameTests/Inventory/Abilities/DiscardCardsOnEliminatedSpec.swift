//
//  DiscardCardsOnEliminatedSpec.swift
//
//
//  Created by Hugues Telolahy on 18/05/2023.
//

import Quick
import Nimble
import Game

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
                    let action = GameAction.eliminate(player: "p1")
                    let result = self.awaitAction(action, state: state)
                    
                    // Then
                    expect(result) == [
                        .success(.eliminate(player: "p1")),
                        .success(.discard("c2", player: "p1")),
                        .success(.discard("c1", player: "p1"))
                    ]
                }
            }
        }
    }
}
