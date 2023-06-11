//
//  HandicapSpec.swift
//  
//
//  Created by Hugues Telolahy on 11/06/2023.
//

import Quick
import Nimble
import Game

final class HandicapSpec: QuickSpec {
    override func spec() {
        let sut = GameReducer()

        describe("handicap card") {
            it("should put card in target's inplay") {
                // Given
                let state = GameState {
                    Player("p1") {
                        Hand {
                            "c1"
                            "c2"
                        }
                    }
                    Player("p2")
                }

                // When
                let action = GameAction.handicap(actor: "p1", card: "c1", target: "p2")
                let result = sut.reduce(state: state, action: action)

                // Then
                expect(result.player("p1").hand.cards) == ["c2"]
                expect(result.player("p2").inPlay.cards) == ["c1"]
                expect(result.player("p1").inPlay.cards).to(beEmpty())
                expect(result.discard.count) == 0
            }
        }
    }
}
