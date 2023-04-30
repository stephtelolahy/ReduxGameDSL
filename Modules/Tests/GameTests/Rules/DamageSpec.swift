//
//  DamageSpec.swift
//  
//
//  Created by Hugues Telolahy on 16/04/2023.
//

@testable import Game
import Quick
import Nimble

final class DamageSpec: QuickSpec {
    override func spec() {
        let sut = GameReducer()
        let ctx = EffectContext(actor: "p1", card: "cx")
        var state: GameState!
        
        describe("damage") {
            // Given
            beforeEach {
                state = GameState {
                    Player("p1")
                        .health(2)
                }
            }

            context("1 life point") {
                it("should reduce life point by 1") {
                    // When
                    let action = CardEffect.damage(1, player: .id("p1")).withCtx(ctx)
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.player("p1").health) == 1
                }
            }

            context("two life points") {
                it("should reduce life point by 2") {
                    // When
                    let action = CardEffect.damage(2, player: .id("p1")).withCtx(ctx)
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.player("p1").health) == 0
                }
            }
        }
    }
}
