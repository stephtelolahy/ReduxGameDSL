//
//  SetTurnSpec.swift
//  
//
//  Created by Hugues Telolahy on 01/05/2023.
//

import Quick
import Nimble
@testable import Game

final class SetTurnSpec: QuickSpec {
    override func spec() {
        let sut = GameReducer()
        let ctx = EffectContext(actor: "p1", card: "cx")
        
        describe("setting turn") {
            it("should set attribute and reset counters") {
                // Given
                let state = GameState()
                    .turn("px")
                    .counters(["counter1": 1, "counter2": 2])
                let action = CardEffect.setTurn(.id("p1")).withCtx(ctx)
                
                // When
                let result = sut.reduce(state: state, action: action)

                // Then
                expect(result.turn) == "p1"
                expect(result.event) == .setTurn("p1")
                expect(result.counters).to(beEmpty())
            }
        }
    }
}
