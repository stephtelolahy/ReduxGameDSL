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
                            .attribute(.health, 0)
                            .ability(.eliminateOnLooseLastHealth)
                        Player("p2")
                    }
                    .event(.damage(1, player: "p1"))

                    // When
                    let action = GameAction.update
                    let result = self.awaitAction(action, state: state)

                    // Then
                    expect(result) == [
                        .success(.trigger(actor: "p1", card: .eliminateOnLooseLastHealth)),
                        .success(.eliminate("p1"))
                    ]
                }
            }

            context("loosing non last health") {
                it("should remain active") {
                    // Given
                    let state = createGame {
                        Player("p1")
                            .attribute(.health, 1)
                            .ability(.eliminateOnLooseLastHealth)
                    }
                    .event(.damage(1, player: "p1"))

                    // When
                    let action = GameAction.update
                    let result = self.awaitAction(action, state: state)

                    // Then
                    expect(result).to(beEmpty())
                }
            }
        }
    }
}
