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
                    let result = self.awaitAction(.play(actor: "p1", card: .generalStore),
                                                  choices: ["c1", "c2"],
                                                  state: state)
                    
                    // Then
                    expect(result) == [
                        .success(.play(actor: "p1", card: .generalStore)),
                        .success(.reveal),
                        .success(.reveal),
                        .success(.reveal),
                        .success(.chooseCard(player: "p1", card: "c1")),
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
                    let result = self.awaitAction(.play(actor: "p1", card: .generalStore),
                                                  choices: ["c1"],
                                                  state: state)
                    
                    // Then
                    expect(result) == [
                        .success(.play(actor: "p1", card: .generalStore)),
                        .success(.reveal),
                        .success(.reveal),
                        .success(.chooseCard(player: "p1", card: "c1")),
                        .success(.chooseCard(player: "p2", card: "c2"))
                    ]
                }
            }
        }
    }
}
