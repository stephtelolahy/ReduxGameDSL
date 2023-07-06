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
                    let action = GameAction.playImmediate(.missed, actor: "p1")
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.event) == .error(.cardNotPlayable(.missed))
                }
            }

            context("immediate card") {
                it("should discard immediately") {
                    // Given
                    let state = createGameWithCardRef {
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

                    // When
                    let action = GameAction.play(.beer, actor: "p1")
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.queue) == [
                        .playImmediate(.beer, actor: "p1")
                    ]
                    expect(result.event) == action
                }
            }

            context("equipment card") {
                it("should put in self's play") {
                    // Given
                    let state = createGameWithCardRef {
                        Player("p1") {
                            Hand {
                                .dynamite
                            }
                        }
                    }

                    // When
                    let action = GameAction.play(.dynamite, actor: "p1")
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.queue) == [
                        .playEquipment(.dynamite, actor: "p1")
                    ]
                    expect(result.event) == action
                }
            }

            context("handicap card") {
                it("should put in target's play") {
                    // Given
                    let state = createGameWithCardRef {
                        Player("p1") {
                            Hand {
                                .jail
                            }
                        }
                        Player("p2")
                        Player("p3")
                    }

                    // When
                    let action = GameAction.play(.jail, actor: "p1")
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.queue) == [
                        .chooseOne(player: "p1", options: [
                            "p3": .playHandicap(.jail, target: "p3", actor: "p1"),
                            "p2": .playHandicap(.jail, target: "p2", actor: "p1")])
                    ]
                    expect(result.event) == action
                }
            }
        }
    }
}
