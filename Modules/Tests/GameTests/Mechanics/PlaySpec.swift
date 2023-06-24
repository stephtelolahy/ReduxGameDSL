//
//  PlaySpec.swift
//
//
//  Created by Hugues Telolahy on 11/06/2023.
//

import Quick
import Nimble
import Game

final class PlaySpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        let sut = GameReducer()

        describe("playing") {
            context("not playable card") {
                it("should throw error") {
                    // Given
                    let state = GameState {
                        Player("p1") {
                            Hand {
                                .missed
                            }
                        }
                    }

                    // When
                    let action = GameAction.playImmediate(actor: "p1", card: .missed)
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.error) == .cardNotPlayable(.missed)
                }
            }

            context("immediate card") {
                it("should discard immediately") {
                    // Given
                    let state = GameState {
                        Player("p1") {
                            Hand {
                                .beer
                            }
                        }
                        .attribute(.health, 1)
                        .attribute(.maxHealth, 3)
                        Player("p2")
                        Player("p3")
                    }
                    .cardRef(CardList.all)

                    // When
                    let action = GameAction.play(.beer, actor: "p1")
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.queue) == [
                        .playImmediate(actor: "p1", card: .beer)
                    ]
                    expect(result.error) == nil
                }
            }

            context("equipment card") {
                it("should put in self's play") {
                    // Given
                    let state = GameState {
                        Player("p1") {
                            Hand {
                                .dynamite
                            }
                        }
                    }
                    .cardRef(CardList.all)

                    // When
                    let action = GameAction.play(.dynamite, actor: "p1")
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.queue) == [
                        .playEquipment(actor: "p1", card: .dynamite)
                    ]
                    expect(result.error) == nil
                }
            }

            context("handicap card") {
                it("should put in target's play") {
                    // Given
                    let state = GameState {
                        Player("p1") {
                            Hand {
                                .jail
                            }
                        }
                        Player("p2")
                        Player("p3")
                    }
                    .cardRef(CardList.all)

                    // When
                    let action = GameAction.play(.jail, actor: "p1")
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.queue) == [
                        .chooseOne(player: "p1", options: [
                            "p3": .playHandicap(actor: "p1", card: .jail, target: "p3"),
                            "p2": .playHandicap(actor: "p1", card: .jail, target: "p2")])
                    ]
                    expect(result.error) == nil
                }
            }
        }
    }
}
