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
                        .attribute(.health, value: 4)
                        .attribute(.maxHealth, value: 4)
                        Player("p2")
                            .attribute(.health, value: 2)
                            .attribute(.maxHealth, value: 4)
                        Player("p3")
                            .attribute(.health, value: 3)
                            .attribute(.maxHealth, value: 4)
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
                        .attribute(.health, value: 4)
                        .attribute(.maxHealth, value: 4)
                        Player("p2")
                            .attribute(.health, value: 3)
                            .attribute(.maxHealth, value: 3)
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
