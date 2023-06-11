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
        let beer = Card("beer") {
            CardEffect.heal(1)
                .target(.actor)
                .require {
                    PlayReq.isPlayersAtLeast(3)
                }
                .triggered(.onPlay)
        }
        let saloon = Card("saloon") {
            CardEffect.heal(1)
                .target(.damaged)
                .triggered(.onPlay)
        }
        let gatling = Card("gatling") {
            CardEffect.damage(1)
                .target(.others)
                .triggered(.onPlay)
        }
        let cardRef = [
            "beer": beer,
            "saloon": saloon,
            "gatling": gatling
        ]

        describe("activating card") {
            context("game idle") {
                it("should emit current turn's active card") {
                    // Given
                    let state = GameState {
                        Player("p1") {
                            Hand {
                                "beer"
                                "saloon"
                                "gatling"
                            }
                        }
                        .attribute(.health, 2)
                        .attribute(.maxHealth, 4)
                        Player("p2")
                    }
                    .turn("p1")
                    .cardRef(cardRef)

                    // When
                    let action = GameAction.groupActions([])
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.event) == nil
                    expect(result.error) == nil
                    expect(result.active) == ActiveCards(player: "p1", cards: [
                        "saloon",
                        "gatling"
                    ])
                }
            }
        }
    }
}
