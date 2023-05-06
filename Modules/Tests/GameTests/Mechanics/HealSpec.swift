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
        let sut = GameReducer()
        let ctx = EffectContext(actor: "p1", card: "cx")
        var state: GameState!

        describe("heal") {
            context("being damaged") {

                beforeEach {
                    // Given
                    state = GameState {
                        Player("p1")
                            .attribute(.health, 2)
                            .attribute(.maxHealth, 4)
                    }
                }

                context("value less than damage") {
                    it("should gain life points") {
                        // When
                        let action = CardEffect.heal(1, player: .id("p1")).withCtx(ctx)
                        let result = sut.reduce(state: state, action: action)

                        // Then
                        expect(result.player("p1").attributes[.health]) == 3
                        expect(result.event) == .heal(1, player: "p1")
                    }
                }

                context("value equal to damage") {
                    it("should gain life points") {
                        // When
                        let action = CardEffect.heal(2, player: .id("p1")).withCtx(ctx)
                        let result = sut.reduce(state: state, action: action)

                        // Then
                        expect(result.player("p1").attributes[.health]) == 4
                        expect(result.event) == .heal(2, player: "p1")
                    }
                }

                context("value more than damage") {
                    it("should gain life points limited to max health") {
                        // When
                        let action = CardEffect.heal(3, player: .id("p1")).withCtx(ctx)
                        let result = sut.reduce(state: state, action: action)

                        // Then
                        expect(result.player("p1").attributes[.health]) == 4
                        expect(result.event) == .heal(3, player: "p1")
                    }
                }
            }

            context("already max health") {
                it("should throw error") {
                    // Given
                    let state = GameState {
                        Player("p1")
                            .attribute(.health, 4)
                            .attribute(.maxHealth, 3)
                    }

                    // When
                    let action = CardEffect.heal(1, player: .id("p1")).withCtx(ctx)
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.error) == .playerAlreadyMaxHealth("p1")
                }
            }
        }
    }
}
