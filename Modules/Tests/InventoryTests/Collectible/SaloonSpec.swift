//
//  SaloonSpec.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

import Quick
import Nimble
import Game
import Inventory

final class SaloonSpec: QuickSpec {
    override func spec() {
        describe("playing saloon") {
            context("any players damaged") {
                it("should heal one life point") {
                    // Given
                    let state = createGame {
                        Player("p1") {
                            Hand {
                                .saloon
                            }
                        }
                        .health(4)
                        .maxHealth(4)
                        Player("p2")
                            .health(2)
                            .maxHealth(4)
                        Player("p3")
                            .health(3)
                            .maxHealth(4)
                    }
                    
                    // When
                    let action = GameAction.play(actor: "p1", card: .saloon)
                    let result = self.awaitAction(action, state: state)
                    
                    // Then
                    expect(result) == [.success(.play(actor: "p1", card: .saloon)),
                                       .success(.heal(1, player: "p2")),
                                       .success(.heal(1, player: "p3"))]
                }
            }
            
            context("no player damaged") {
                it("should throw error") {
                    // Given
                    let state = createGame {
                        Player("p1") {
                            Hand {
                                .saloon
                            }
                        }
                        .health(4)
                        .maxHealth(4)
                        Player("p2")
                            .health(3)
                            .maxHealth(3)
                    }
                    
                    // When
                    let action = GameAction.play(actor: "p1", card: .saloon)
                    let result = self.awaitAction(action, state: state)
                    
                    // Then
                    expect(result) == [.failure(.mismatched(.isAnyDamaged))]
                }
            }
        }
    }
}
