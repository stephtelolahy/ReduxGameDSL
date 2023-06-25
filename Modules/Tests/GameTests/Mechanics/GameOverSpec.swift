//
//  GameOverSpec.swift
//  
//
//  Created by Hugues Telolahy on 06/05/2023.
//

import Quick
import Nimble
import Game

final class GameOverSpec: QuickSpec {
    override func spec() {
        let sut = GameReducer()

        describe("a game") {
            context("one player last") {
                it("should be over") {
                    // Given
                    let state = GameState {
                        Player("p1")
                        Player("p2")
                    }

                    // When
                    let action = GameAction.eliminate(player: "p2")
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.isOver) == GameOver(winner: "p1")
                }
            }

            context("two player") {
                it("should not be over") {
                    // Given
                    let state = GameState {
                        Player("p1")
                        Player("p2")
                        Player("p3")
                    }

                    // When
                    let action = GameAction.eliminate(player: "p3")
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.isOver) == nil
                }
            }
        }

        context("when over") {
            it("should not handle any action") {
                // Given
                let state = GameState()
                    .isOver("p1")

                // When
                let action = GameAction.play("c1", actor: "p1")
                let result = sut.reduce(state: state, action: action)

                // Then
                expect(result.event) == nil
                expect(result.error) == nil
            }
        }
    }
}
