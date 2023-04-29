//
//  DuelSpec.swift
//  
//
//  Created by Hugues Telolahy on 26/04/2023.
//

import Quick
import Nimble
import Game
import Inventory

final class DuelSpec: QuickSpec {
    override func spec() {
        describe("playing Duel") {
            
            context("without target") {
                it("should ask to select target") {
                    // Given
                    let state = createGame {
                        Player("p1") {
                            Hand {
                                .duel
                            }
                        }
                        Player("p2")
                        Player("p3")
                        Player("p4")
                    }

                    // When
                    let result = self.awaitSequence(
                        action: .play(actor: "p1", card: .duel),
                        choices: "p4", .pass,
                        state: state
                    )

                    // Then
                    expect(result) == [
                        .success(.play(actor: "p1", card: .duel, target: "p4")),
                        .success(.damage(1, player: .id("p4")))
                    ]
                }
            }
            
            context("with target") {
                context("passing") {
                    it("should damage") {
                        // Given
                        let state = createGame {
                            Player("p1") {
                                Hand {
                                    .duel
                                }
                            }
                            Player("p2")
                        }
                        
                        // When
                        let result = self.awaitSequence(
                            action: .play(actor: "p1", card: .duel, target: "p2"),
                            choices: .pass,
                            state: state
                        )
                        
                        // Then
                        expect(result) == [
                            .success(.play(actor: "p1", card: .duel, target: "p2")),
                            .success(.damage(1, player: .id("p2")))
                        ]
                    }
                }
                
                xcontext("discarding bang") {
                    it("should damage actor") {
                        // Given
                        // When
                        // Then
                    }
                }
                
                xcontext("target and actor discarding bang") {
                    it("should damage target") {
                        // Given
                        // When
                        // Then
                    }
                }
            }
        }
    }
}
