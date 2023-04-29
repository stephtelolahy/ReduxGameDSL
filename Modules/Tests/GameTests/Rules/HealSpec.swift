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
                            .health(2)
                            .maxHealth(4)
                    }
                }

                context("value less than damage") {
                    it("should gain life points") {
                        // When
                        let action = GameAction.heal(1, player: .id("p1"), ctx: ctx)
                        let result = sut.reduce(state: state, action: action)

                        // Then
                        expect(result.player("p1").health) == 3
                    }
                }

                context("value equal to damage") {
                    it("should gain life points") {
                        // When
                        let action = GameAction.heal(2, player: .id("p1"), ctx: ctx)
                        let result = sut.reduce(state: state, action: action)

                        // Then
                        expect(result.player("p1").health) == 4
                    }
                }

                context("value more than damage") {
                    it("should gain life points limited to max health") {
                        // When
                        let action = GameAction.heal(3, player: .id("p1"), ctx: ctx)
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
                    let action = GameAction.heal(1, player: .id("p1"), ctx: ctx)
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.event) == .failure(.playerAlreadyMaxHealth("p1"))
                }
            }
        }
    }
}
