//
//  SaloonSpec.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

import Quick
import Nimble
import Game

final class SaloonSpec: QuickSpec {
    override func spec() {
        describe("playing saloon") {
            context("any players damaged") {
                it("should heal one life point") {
                    // Given
                    let state = GameState {
                        Player("p1") {
                            Hand {
                                "saloon-5♥️"
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
                    let sut = createGameStore(initial: state)

                    // When
                    let action = GameAction.play(actor: "p1", card: "saloon-5♥️")
                    let result = self.awaitAction(action, store: sut)

                    // Then
                    let ctx = EffectContext(actor: "p1", card: "saloon-5♥️")
                    expect(result) == [.success(.play(actor: "p1", card: "saloon-5♥️")),
                                       .success(.apply(.heal(1, player: .id("p2")), ctx: ctx)),
                                       .success(.apply(.heal(1, player: .id("p3")), ctx: ctx))]
                }
            }

            context("no player damaged") {
                it("should throw error") {
                    // Given
                    let state = GameState {
                        Player("p1") {
                            Hand {
                                "saloon-5♥️"
                            }
                        }
                        .health(4)
                        .maxHealth(4)
                        Player("p2")
                            .health(3)
                            .maxHealth(3)
                    }
                    let sut = createGameStore(initial: state)

                    // When
                    let action = GameAction.play(actor: "p1", card: "saloon-5♥️")
                    let result = self.awaitAction(action, store: sut)

                    // Then
                    expect(result) == [.failure(.noPlayerDamaged)]
                }
            }
        }
    }
}
