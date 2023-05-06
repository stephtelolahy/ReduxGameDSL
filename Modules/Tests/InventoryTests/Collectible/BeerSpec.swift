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
                        .attribute(.health, value: 2)
                        .attribute(.maxHealth, value: 3)
                        Player()
                        Player()
                    }

                    // When
                    let action = GameAction.play(actor: "p1", card: .beer)
                    let result = self.awaitAction(action, state: state)

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
                        .attribute(.health, value: 3)
                        .attribute(.maxHealth, value: 3)
                        Player()
                        Player()
                    }

                    // When
                    let action = GameAction.play(actor: "p1", card: .beer)
                    let result = self.awaitAction(action, state: state)

                    // Then
                    expect(result) == [.failure(.mismatched(.isDamaged))]
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
                        .attribute(.health, value: 2)
                        .attribute(.maxHealth, value: 3)
                        Player()
                    }

                    // When
                    let action = GameAction.play(actor: "p1", card: .beer)
                    let result = self.awaitAction(action, state: state)

                    // Then
                    expect(result) == [.failure(.mismatched(.isPlayersAtLeast(3)))]
                }
            }
        }
    }
}
