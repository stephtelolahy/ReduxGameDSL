//
//  HealSpec.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

import Quick
import Nimble
import Game

final class HealSpec: QuickSpec {
    override func spec() {
        let sut = GameReducer()
        let ctx = EffectContext(actor: "p1", card: "cx")

        describe("heal") {
            context("being damaged") {
                context("value less than damage") {
                    it("should gain life points") {
                        // Given
                        let state = GameState {
                            Player("p1")
                                .health(2)
                                .maxHealth(4)
                        }

                        // When
                        let action = GameAction.apply(.heal(1, player: .id("p1")), ctx: ctx)
                        let result = sut.reduce(state: state, action: action)

                        // Then
                        expect(result.player("p1").health) == 3
                    }
                }

                context("value equal to damage") {
                    it("should gain life points") {
                        // Given
                        let state = GameState {
                            Player("p1")
                                .health(2)
                                .maxHealth(4)
                        }

                        // When
                        let action = GameAction.apply(.heal(2, player: .id("p1")), ctx: ctx)
                        let result = sut.reduce(state: state, action: action)

                        // Then
                        expect(result.player("p1").health) == 4
                    }
                }

                context("value more than damage") {
                    it("should gain life points limited to max health") {
                        // Given
                        let state = GameState {
                            Player("p1")
                                .health(3)
                                .maxHealth(4)
                        }

                        // When
                        let action = GameAction.apply(.heal(2, player: .id("p1")), ctx: ctx)
                        let result = sut.reduce(state: state, action: action)

                        // Then
                        expect(result.player("p1").health) == 4
                    }
                }
            }

            context("already max health") {
                it("should throw error") {
                    // Given
                    let state = GameState {
                        Player("p1")
                            .health(4)
                            .maxHealth(4)
                    }

                    // When
                    let action = GameAction.apply(.heal(1, player: .id("p1")), ctx: ctx)
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.thrownError) == GameError.playerAlreadyMaxHealth("p1")
                }
            }
        }
    }
}
