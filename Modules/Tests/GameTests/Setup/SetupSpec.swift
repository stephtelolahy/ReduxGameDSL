//
//  SetupSpec.swift
//  
//
//  Created by Hugues Telolahy on 19/05/2023.
//

import Quick
import Nimble
import Game

final class SetupSpec: QuickSpec {
    override func spec() {
        var state: GameState!

        describe("setup a game") {
            context("two players") {

                beforeEach {
                    // Given
                    let deck = Array(1...80).map { "c\($0)" }
                    let figures = [
                        Figure(name: "p1", bullets: 4),
                        Figure(name: "p2", bullets: 3)
                    ]
                    let abilities = ["a1", "a2"]

                    // When
                    state = Setup.createGame(figures: figures,
                                             abilities: abilities,
                                             deck: deck)
                }

                it("should create a game with given player number") {
                    expect(state.players.count) == 2
                    expect(state.playOrder).to(contain(["p1", "p2"]))
                    expect(state.setupOrder).to(contain(["p1", "p2"]))
                }

                it("should set players to max health") {
                    expect(state.player("p1").attributes[.health]) == 4
                    expect(state.player("p1").attributes[.maxHealth]) == 4
                    expect(state.player("p2").attributes[.health]) == 3
                    expect(state.player("p2").attributes[.maxHealth]) == 3
                }

                it("should set players hand cards to health") {
                    expect(state.player("p1").hand.count) == 4
                    expect(state.player("p2").hand.count) == 3
                }

                it("should set default abilities") {
                    expect(state.player("p1").abilities).to(beEmpty())
                    expect(state.player("p2").abilities).to(beEmpty())
                    expect(state.abilities) == ["a1", "a2"]
                }

                xit("should contains card references") {
                }
            }
        }
    }
}
