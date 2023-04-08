//
//  BeerSpec.swift
//  
//
//  Created by Hugues Telolahy on 08/04/2023.
//

import Quick
import Nimble
import Game

final class BeerSpec: QuickSpec {

    override func spec() {
        describe("playing beer") {
            context("damaged") {
                it("should heal one life point") {
                    // Given
                    let ctx = GameState {
                        Player("p1") {
                            Hand {
                                "beer-6♥️"
                            }
                        }
                        .health(2)
                        .maxHealth(3)
                        Player()
                        Player()
                    }
                    let store = createGameStore(initial: ctx)

                    // When
                    let action = GameAction.play(actor: "p1", card: "beer-6♥️")
                    let result = self.awaitAction(action, store: store)

                    // Then
                    expect(result) == [.success(.play(actor: "p1", card: "beer-6♥️")),
                                       .success(.apply(.heal(1, player: .id("p1"))))]
                }
            }

            context("already max health") {
                it("should throw error") {
                    // Given
                    let ctx = GameState {
                        Player("p1") {
                            Hand {
                                "beer-6♥️"
                            }
                        }
                        .health(3)
                        .maxHealth(3)
                        Player()
                        Player()
                    }
                    let store = createGameStore(initial: ctx)

                    // When
                    let action = GameAction.play(actor: "p1", card: "beer-6♥️")
                    let result = self.awaitAction(action, store: store)

                    // Then
                    expect(result) == [.failure(.playerAlreadyMaxHealth("p1"))]
                }
            }

            context("two players left") {
                it("should throw error") {
                    // Given
                    let ctx = GameState {
                        Player("p1") {
                            Hand {
                                "beer-6♥️"
                            }
                        }
                        .health(2)
                        .maxHealth(3)
                        Player()
                    }
                    let store = createGameStore(initial: ctx)

                    // When
                    let action = GameAction.play(actor: "p1", card: "beer-6♥️")
                    let result = self.awaitAction(action, store: store)

                    // Then
                    expect(result) == [.failure(.playersMustBeAtLeast(3))]
                }
            }
        }
    }
}
