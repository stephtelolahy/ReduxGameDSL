//
//  ActiveCardsSpec.swift
//  
//
//  Created by Hugues Telolahy on 05/06/2023.
//

import Quick
import Nimble
import Game

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
                    let action = GameAction.groupActions([])
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.event) == nil
                    expect(result.error) == nil
                    expect(result.active) == ActiveCards(player: "p1", cards: [
                        .saloon,
                        .gatling
                    ])
                }
            }
        }
    }
}
