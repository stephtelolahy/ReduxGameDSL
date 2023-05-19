//
//  ChooseOneSpec.swift
//  
//
//  Created by Hugues Telolahy on 11/04/2023.
//

import Game
import Quick
import Nimble
import Redux

final class ChooseOneSpec: QuickSpec {
    override func spec() {
        let sut = GameReducer()
        var state: GameState!

        describe("chooseOne") {
            beforeEach {
                state = GameState()
                    .waiting("p1", options: [
                        "c1": .play(actor: "p1", card: "c1"),
                        "c2": .play(actor: "p1", card: "c2")
                    ])
            }

            context("when dispatching waited action") {
                it("should remove waiting state") {
                    // When
                    let action = GameAction.play(actor: "p1", card: "c1")
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.chooseOne) == nil
                }
            }

            context("when dispatching non waited action") {
                it("should throw error") {
                    // When
                    let action = GameAction.play(actor: "p1", card: "c3")
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.chooseOne) != nil
                    expect(result.error) == .unwaitedAction
                }
            }
        }
    }
}
