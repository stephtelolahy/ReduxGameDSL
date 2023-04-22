//
//  ForceDiscardSpec.swift
//  
//
//  Created by Hugues Telolahy on 16/04/2023.
//

import Quick
import Nimble
@testable import Game

final class ForceDiscardSpec: QuickSpec {
    override func spec() {
        let sut = GameReducer()
        let ctx = EffectContext(actor: "px", card: "cx", target: "p1")

        describe("force discard") {
            context("having required card") {
                it("should ask to choose card or pass") {
                    // Given
                    let state = GameState {
                        Player("p1") {
                            Hand {
                                "missed-10♣️"
                                "missed-8♠️"
                            }
                        }
                    }

                    // When
                    let action = GameAction.apply(.forceDiscard(player: .id("p1"),
                                                                card: .selectHandNamed(.missed),
                                                                otherwise: .damage(1, player: .target)), ctx: ctx)
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.chooseOne) == ChooseOne(chooser: "p1", options: [
                        "missed-10♣️": .apply(.discard(player: .id("p1"), card: .id("missed-10♣️")), ctx: ctx),
                        "missed-8♠️": .apply(.discard(player: .id("p1"), card: .id("missed-8♠️")), ctx: ctx),
                        Label.pass: .apply(.damage(1, player: .target), ctx: ctx)
                    ])
                }
            }

            context("not having required card") {
                it("should ask to pass") {
                    // Given
                    let state = GameState {
                        Player("p1")
                    }

                    // When
                    let action = GameAction.apply(.forceDiscard(player: .id("p1"),
                                                                card: .selectHandNamed(.missed),
                                                                otherwise: .damage(1, player: .target)), ctx: ctx)
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.chooseOne) == ChooseOne(chooser: "p1", options: [
                        Label.pass: .apply(.damage(1, player: .target), ctx: ctx)
                    ])
                }
            }
        }
    }
}
