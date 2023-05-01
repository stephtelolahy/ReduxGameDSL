//
//  EndTurnSpec.swift
//  
//
//  Created by Hugues Telolahy on 01/05/2023.
//

import Quick
import Nimble
import Game
import Inventory

final class EndTurnSpec: QuickSpec {
    override func spec() {
        describe("ending turn") {
            context("no excess cards") {
                it("should discard nothing") {
                    // Given
                    let state = createGame {
                        Player("p1")
                        Player("p2")
                    }
                    .turn("p1")

                    // When
                    let action = GameAction.invoke(actor: "p1", card: .endTurn)
                    let result = self.awaitAction(action, state: state)

                    // Then
                    expect(result) == [
                        .success(.invoke(actor: "p1", card: .endTurn)),
                        .success(.setTurn("p2"))
                    ]
                }
            }

            context("having excess card") {
                it("should discard cards") {
                    // Given
                    let state = createGame {
                        Player("p1") {
                            Hand {
                                "c1"
                                "c2"
                                "c3"
                            }
                        }
                        .health(1)
                        Player("p2")
                    }
                    .turn("p1")

                    // When
                    let action = GameAction.invoke(actor: "p1", card: .endTurn)
                    let result = self.awaitAction(action, choices: ["c1", "c3"], state: state)

                    // Then
                    expect(result) == [
                        .success(.invoke(actor: "p1", card: .endTurn)),
                        .success(.chooseOne(chooser: "p1", options: ["c1", "c2", "c3"])),
                        .success(.discard(player: "p1", card: "c1")),
                        .success(.chooseOne(chooser: "p1", options: ["c2", "c3"])),
                        .success(.discard(player: "p1", card: "c3")),
                        .success(.setTurn("p2"))
                    ]
                }
            }
        }
    }
}
