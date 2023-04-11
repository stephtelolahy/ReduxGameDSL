//
//  HealSpec.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

@testable import Game
import Quick
import Nimble

final class HealSpec: QuickSpec {
    override func spec() {
        let sut: EffectReducer = healReducer
        let ctx = PlayContext(actor: "p1", card: "cx")

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
                        let effect = CardEffect.heal(1, player: .id("p1"))
                        let result = try sut(effect, state, ctx)

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
                        let effect = CardEffect.heal(2, player: .id("p1"))
                        let result = try sut(effect, state, ctx)

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
                        let effect = CardEffect.heal(2, player: .id("p1"))
                        let result = try sut(effect, state, ctx)

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
                    // Then
                    let effect = CardEffect.heal(1, player: .id("p1"))
                    expect { try sut(effect, state, ctx) }
                        .to(throwError(GameError.playerAlreadyMaxHealth("p1")))
                }
            }
        }
    }
}
