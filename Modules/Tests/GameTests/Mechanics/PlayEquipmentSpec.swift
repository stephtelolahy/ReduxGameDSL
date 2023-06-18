//
//  PlayEquipmentSpec.swift
//  
//
//  Created by Hugues Telolahy on 10/06/2023.
//

import Quick
import Nimble
import Game

final class PlayEquipmentSpec: QuickSpec {
    override func spec() {
        let sut = GameReducer()

        describe("playing equipment a card") {
            it("should put card in play") {
                // Given
                let state = GameState {
                    Player("p1") {
                        Hand {
                            "c1"
                            "c2"
                        }
                    }
                }

                // When
                let action = GameAction.playEquipment(actor: "p1", card: "c1")
                let result = sut.reduce(state: state, action: action)

                // Then
                expect(result.player("p1").hand.cards) == ["c2"]
                expect(result.player("p1").inPlay.cards) == ["c1"]
                expect(result.discard.count) == 0
            }
        }
    }
}
