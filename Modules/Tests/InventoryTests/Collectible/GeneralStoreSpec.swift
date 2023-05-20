//
//  GeneralStoreSpec.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

import Quick
import Nimble
import Game
import Inventory

final class GeneralStoreSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        describe("playing generalStore") {
            context("three players") {
                it("should allow each player to choose a card") {
                    // Given
                    let state = createGame {
                        Player("p1") {
                            Hand {
                                .generalStore
                            }
                        }
                        Player("p2")
                        Player("p3")
                        Deck {
                            "c1"
                            "c2"
                            "c3"
                        }
                    }
                    
                    // When
                    let action = GameAction.move(actor: "p1", card: .generalStore)
                    let result = self.awaitAction(action, choices: ["c1", "c2"], state: state)
                    
                    // Then
                    expect(result) == [
                        .success(.play(actor: "p1", card: .generalStore)),
                        .success(.drawToArena),
                        .success(.drawToArena),
                        .success(.drawToArena),
                        .success(.chooseOne(chooser: "p1", options: [
                            "c1": .chooseCard(player: "p1", card: "c1"),
                            "c2": .chooseCard(player: "p1", card: "c2"),
                            "c3": .chooseCard(player: "p1", card: "c3")
                        ])),
                        .success(.chooseCard(player: "p1", card: "c1")),
                        .success(.chooseOne(chooser: "p2", options: [
                            "c2": .chooseCard(player: "p2", card: "c2"),
                            "c3": .chooseCard(player: "p2", card: "c3")
                        ])),
                        .success(.chooseCard(player: "p2", card: "c2")),
                        .success(.chooseCard(player: "p3", card: "c3"))
                    ]
                }
            }
            
            context("two players") {
                it("should allow each player to choose a card") {
                    // Given
                    let state = createGame {
                        Player("p1") {
                            Hand {
                                .generalStore
                            }
                        }
                        Player("p2")
                        Deck {
                            "c1"
                            "c2"
                        }
                    }
                    
                    // When
                    let action = GameAction.move(actor: "p1", card: .generalStore)
                    let result = self.awaitAction(action, choices: ["c1"], state: state)
                    
                    // Then
                    expect(result) == [
                        .success(.play(actor: "p1", card: .generalStore)),
                        .success(.drawToArena),
                        .success(.drawToArena),
                        .success(.chooseOne(chooser: "p1", options: [
                            "c1": .chooseCard(player: "p1", card: "c1"),
                            "c2": .chooseCard(player: "p1", card: "c2")
                        ])),
                        .success(.chooseCard(player: "p1", card: "c1")),
                        .success(.chooseCard(player: "p2", card: "c2"))
                    ]
                }
            }
        }
    }
}
