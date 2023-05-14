//
//  EliminateOnLooseLastHealthSpec.swift
//  
//
//  Created by Hugues Telolahy on 05/05/2023.
//

@testable import Game
import Quick
import Nimble

final class EliminateOnLooseLastHealthSpec: QuickSpec {
    override func spec() {

        describe("a player") {
            context("loosing last health") {
                it("should be eliminated") {
                    // Given
                    let state = createGame {
                        Player("p1")
                            .attribute(.health, 1)
                        Player("p2")
                    }
                    .ability(.eliminateOnLooseLastHealth)

                    // When
                    let action = GameAction.damage(player: "p1", value: 1)
                    let result = self.awaitAction(action, state: state)

                    // Then
                    expect(result) == [
                        .success(.damage(player: "p1", value: 1)),
                        .success(.eliminate("p1"))
                    ]
                }
            }

            context("loosing non last health") {
                it("should remain active") {
                    // Given
                    let state = createGame {
                        Player("p1")
                            .attribute(.health, 2)
                    }
                    .ability(.eliminateOnLooseLastHealth)

                    // When
                    let action = GameAction.damage(player: "p1", value: 1)
                    let result = self.awaitAction(action, state: state)

                    // Then
                    expect(result) == [
                        .success(.damage(player: "p1", value: 1))
                    ]
                }
            }
        }
    }
}
