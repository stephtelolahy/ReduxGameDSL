//
//  EliminateSpec.swift
//  
//
//  Created by Hugues Telolahy on 05/05/2023.
//

@testable import Game
import Quick
import Nimble

final class EliminateSpec: QuickSpec {
    override func spec() {
        let sut = GameReducer()
        let ctx = EffectContext(actor: "p1", card: "cx")

        describe("eliminating a player") {
            it("should remove from PlayOrder and emit event") {
                // Given
                let state = GameState {
                    Player("p1")
                    Player("p2")
                }

                // When
                let action = CardEffect.eliminate(.id("p1")).withCtx(ctx)
                let result = sut.reduce(state: state, action: action)

                // Then
                expect(result.playOrder) == ["p2"]
                expect(result.event) == .eliminate("p1")
            }
        }
    }
}
