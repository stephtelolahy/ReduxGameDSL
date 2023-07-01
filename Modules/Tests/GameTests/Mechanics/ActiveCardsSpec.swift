//
//  ActiveCardsSpec.swift
//  
//
//  Created by Hugues Telolahy on 05/06/2023.
//

import Quick
import Nimble
@testable import Game

final class ActiveCardsSpec: QuickSpec {
    override func spec() {
        let sut = GameReducer()
        describe("activating card") {
            context("game idle") {
                it("should emit current turn's active card") {
                    // Given
                    let state = GameState {
                        Player("p1") {
                            Hand {
                                String.beer
                                String.saloon
                                String.gatling
                            }
                        }
                        .attribute(.health, 2)
                        .attribute(.maxHealth, 4)
                        Player("p2")
                    }
                    .turn("p1")
                    .cardRef(CardList.all)

                    // When
                    let result = state.evaluateActive()

                    // Then
                    expect(result) == .activateCard(player: "p1", cards: [
                        .saloon,
                        .gatling
                    ])
                }
            }
        }
    }
}
