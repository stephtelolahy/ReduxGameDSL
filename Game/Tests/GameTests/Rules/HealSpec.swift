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

        describe("healing") {
            context("value 1") {
                it("should gain a life point") {
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

            context("value 2") {
                context("damaged by 2") {
                    it("should gain 2 life points") {
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

                context("damaged by 1") {
                    it("should gain only 1 life point") {
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
