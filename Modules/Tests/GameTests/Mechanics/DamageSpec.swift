//
//  DamageSpec.swift
//  
//
//  Created by Hugues Telolahy on 16/04/2023.
//

import Quick
import Nimble
import Game

final class DamageSpec: QuickSpec {
    override func spec() {
        let sut = GameReducer()
        var state: GameState!
        
        describe("damage") {
            // Given
            beforeEach {
                state = GameState {
                    Player("p1")
                        .attribute(.health, 2)
                }
            }

            context("1 life point") {
                it("should reduce life point by 1") {
                    // When
                    let action = GameAction.damage(player: "p1", value: 1)
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.player("p1").attributes[.health]) == 1
                    expect(result.event) == .damage(player: "p1", value: 1)
                }
            }

            context("two life points") {
                it("should reduce life point by 2") {
                    // When
                    let action = GameAction.damage(player: "p1", value: 2)
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.player("p1").attributes[.health]) == 0
                }
            }
        }
    }
}
