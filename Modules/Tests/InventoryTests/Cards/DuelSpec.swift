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
            
            xcontext("without target") {
                it("should ask to select target") {
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
                        let sut = createGameStore(initial: state)
                        
                        // When
                        let action = GameAction.play(actor: "p1", card: .duel, target: "p2")
                        let result = self.awaitAction(action, choices: [.pass], store: sut)
                        
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
