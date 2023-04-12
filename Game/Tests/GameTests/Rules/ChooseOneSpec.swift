//
//  ChooseOneSpec.swift
//  
//
//  Created by Hugues Telolahy on 11/04/2023.
//

import Quick
import Nimble
import Game
import Redux

final class ChooseOneSpec: QuickSpec {
    override func spec() {
        var sut: Store<GameState, GameAction>!

        describe("chooseOne") {
            beforeEach {
                let state = GameState {
                    ChooseOne {
                        GameAction.play(actor: "p1", card: "c1")
                        GameAction.play(actor: "p1", card: "c2")
                    }
                }
                sut = createGameStore(initial: state)
            }

            context("when dispatching waited action") {
                it("should remove waiting state") {
                    // When
                    sut.dispatch(GameAction.play(actor: "p1", card: "c1"))

                    // Then
                    expect(sut.state.chooseOne) == nil
                }
            }

            context("when dispatching non waited action") {
                it("should do nothing") {
                    // When
                    sut.dispatch(GameAction.play(actor: "p1", card: "c3"))

                    // Then
                    expect(sut.state.chooseOne) != nil
                }
            }

            context("when dispatching update") {
                it("should do nothing") {
                    // When
                    sut.dispatch(GameAction.update)

                    // Then
                    expect(sut.state.chooseOne) != nil
                }
            }
        }
    }
}
