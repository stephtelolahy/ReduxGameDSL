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
    // swiftlint:disable:next function_body_length
    override func spec() {
        var state: GameState!

        describe("playing Duel") {
            beforeEach {
                state = createGame {
                    Player("p1") {
                        Hand {
                            .duel
                            "bang-1"
                        }
                    }
                    Player("p2") {
                        Hand {
                            "bang-2"
                        }
                    }
                    Player("p3")
                    Player("p4")
                }
            }
            
            context("without target") {
                it("should ask to select target") {
                    // When
                    let result = self.awaitAction(
                        .play(actor: "p1", card: .duel),
                        choices: ["p4", .pass],
                        state: state
                    )

                    // Then
                    expect(result) == [
                        .success(.play(actor: "p1", card: .duel, target: "p4")),
                        .success(.damage(1, player: "p4"))
                    ]
                }
            }
            
            context("with target") {
                context("passing") {
                    it("should damage") {
                        // When
                        let result = self.awaitAction(
                            .play(actor: "p1", card: .duel, target: "p2"),
                            choices: [.pass],
                            state: state
                        )
                        
                        // Then
                        expect(result) == [
                            .success(.play(actor: "p1", card: .duel, target: "p2")),
                            .success(.damage(1, player: "p2"))
                        ]
                    }
                }
                
                context("discarding bang") {
                    it("should damage actor") {
                        // When
                        let result = self.awaitAction(
                            .play(actor: "p1", card: .duel, target: "p2"),
                            choices: ["bang-2", .pass],
                            state: state
                        )

                        // Then
                        expect(result) == [
                            .success(.play(actor: "p1", card: .duel, target: "p2")),
                            .success(.discard(player: "p2", card: "bang-2")),
                            .success(.damage(1, player: "p1"))
                        ]
                    }
                }
                
                context("target and actor discarding bang") {
                    it("should damage target") {
                        // When
                        let result = self.awaitAction(
                            .play(actor: "p1", card: .duel, target: "p2"),
                            choices: ["bang-2", "bang-1", .pass],
                            state: state
                        )

                        // Then
                        expect(result) == [
                            .success(.play(actor: "p1", card: .duel, target: "p2")),
                            .success(.discard(player: "p2", card: "bang-2")),
                            .success(.discard(player: "p1", card: "bang-1")),
                            .success(.damage(1, player: "p2"))
                        ]
                    }
                }
            }
        }
    }
}
