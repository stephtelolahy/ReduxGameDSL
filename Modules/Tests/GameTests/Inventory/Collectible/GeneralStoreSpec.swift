//
//  GeneralStoreSpec.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

import Quick
import Nimble
import Game

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
                    let action = GameAction.play(.generalStore, actor: "p1")
                    let result = self.awaitAction(action, choices: ["c1", "c2"], state: state)
                    
                    // Then
                    expect(result) == [
                        .success(.playImmediate(actor: "p1", card: .generalStore)),
                        .success(.discover),
                        .success(.discover),
                        .success(.discover),
                        .success(.chooseOne(player: "p1", options: [
                            "c1": .chooseCard("c1", player: "p1"),
                            "c2": .chooseCard("c2", player: "p1"),
                            "c3": .chooseCard("c3", player: "p1")
                        ])),
                        .success(.chooseCard("c1", player: "p1")),
                        .success(.chooseOne(player: "p2", options: [
                            "c2": .chooseCard("c2", player: "p2"),
                            "c3": .chooseCard("c3", player: "p2")
                        ])),
                        .success(.chooseCard("c2", player: "p2")),
                        .success(.chooseCard("c3", player: "p3"))
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
                    let action = GameAction.play(.generalStore, actor: "p1")
                    let result = self.awaitAction(action, choices: ["c1"], state: state)
                    
                    // Then
                    expect(result) == [
                        .success(.playImmediate(actor: "p1", card: .generalStore)),
                        .success(.discover),
                        .success(.discover),
                        .success(.chooseOne(player: "p1", options: [
                            "c1": .chooseCard("c1", player: "p1"),
                            "c2": .chooseCard("c2", player: "p1")
                        ])),
                        .success(.chooseCard("c1", player: "p1")),
                        .success(.chooseCard("c2", player: "p2"))
                    ]
                }
            }
        }
    }
}
