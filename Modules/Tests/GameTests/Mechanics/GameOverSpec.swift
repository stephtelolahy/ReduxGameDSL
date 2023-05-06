//
//  GameOverSpec.swift
//  
//
//  Created by Hugues Telolahy on 06/05/2023.
//

@testable import Game
import Quick
import Nimble

final class GameOverSpec: QuickSpec {
    override func spec() {
        let sut = GameReducer()

        describe("a game") {
            context("one player remains") {
                it("should be over") {
                    // Given
                    let state = GameState {
                        Player("p1")
                    }

                    // When
                    let action = GameAction.update
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.isOver) == GameOver(winner: "p1")
                }
            }

            context("two player remains") {
                it("should not be over") {
                    // Given
                    let state = GameState {
                        Player("p1")
                        Player("p2")
                    }

                    // When
                    let action = GameAction.update
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.isOver) == nil
                }
            }
        }
    }
}
