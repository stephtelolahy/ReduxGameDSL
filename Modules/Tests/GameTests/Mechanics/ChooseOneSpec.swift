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
                state = GameState {
                    Player("p1") {
                        Hand {
                            "beer-1"
                            "beer-2"
                        }
                    }
                    .attribute(.health, 1)
                    .attribute(.maxHealth, 3)
                }
                .waiting("p1", options: [
                    "c1": .discard("beer-1", player: "p1"),
                    "c2": .discard("beer-2", player: "p1")
                ])
                .cardRef(CardList.all)
            }

            context("when dispatching waited action") {
                it("should remove waiting state") {
                    // When
                    let action = GameAction.discard("beer-1", player: "p1")
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.chooseOne) == nil
                    expect(result.error) == nil
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
