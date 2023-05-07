//
//  EliminateSpec.swift
//  
//
//  Created by Hugues Telolahy on 05/05/2023.
//

import Quick
import Nimble
import Game

final class EliminateSpec: QuickSpec {
    override func spec() {
        let sut = GameReducer()

        describe("eliminating a player") {
            it("should remove from PlayOrder and emit event") {
                // Given
                let state = GameState {
                    Player("p1")
                    Player("p2")
                }

                // When
                let action = GameAction.eliminate("p1")
                let result = sut.reduce(state: state, action: action)

                // Then
                expect(result.playOrder) == ["p2"]
                expect(result.event) == .eliminate("p1")
            }
        }
    }
}
