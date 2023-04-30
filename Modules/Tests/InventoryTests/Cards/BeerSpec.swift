//
//  BeerSpec.swift
//  
//
//  Created by Hugues Telolahy on 08/04/2023.
//

import Quick
import Nimble
import Game
import Inventory

final class BeerSpec: QuickSpec {
    override func spec() {
        describe("playing beer") {
            context("being damaged") {
                it("should heal one life point") {
                    // Given
                    let state = createGame {
                        Player("p1") {
                            Hand {
                                .beer
                            }
                        }
                        .health(2)
                        .maxHealth(3)
                        Player()
                        Player()
                    }

                    // When
                    let result = self.awaitAction(.play(actor: "p1", card: .beer), state: state)

                    // Then
                    expect(result) == [.success(.play(actor: "p1", card: .beer)),
                                       .success(.heal(1, player: "p1"))]
                }
            }

            context("already max health") {
                it("should throw error") {
                    // Given
                    let state = createGame {
                        Player("p1") {
                            Hand {
                                .beer
                            }
                        }
                        .health(3)
                        .maxHealth(3)
                        Player()
                        Player()
                    }

                    // When
                    let result = self.awaitAction(.play(actor: "p1", card: .beer), state: state)

                    // Then
                    expect(result) == [.failure(.playerAlreadyMaxHealth("p1"))]
                }
            }

            context("two players left") {
                it("should throw error") {
                    // Given
                    let state = createGame {
                        Player("p1") {
                            Hand {
                                .beer
                            }
                        }
                        .health(2)
                        .maxHealth(3)
                        Player()
                    }

                    // When
                    let result = self.awaitAction(.play(actor: "p1", card: .beer), state: state)

                    // Then
                    expect(result) == [.failure(.playersMustBeAtLeast(3))]
                }
            }
        }
    }
}
