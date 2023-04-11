//
//  ChooseCardSpec.swift
//  
//
//  Created by Hugues Telolahy on 11/04/2023.
//

import Quick
import Nimble
import Game

final class ChooseCardSpec: QuickSpec {
    override func spec() {
        let sut: EffectReducer = effectReducer
        let ctx = PlayContext(actor: "p1", card: "cx")
        describe("choose a card") {
            context("unspecified") {
                context("multiple cards available") {
                    it("should ask a choice") {
                        // Given
                        let state = GameState {
                            Choosable {
                                "c1"
                                "c2"
                            }
                        }

                        // When
                        let effect = CardEffect.chooseCard(player: .id("p1"), card: .selectChoosable)
                        let result = try sut(effect, state, ctx)

                        // Then
                        expect(result.completedAction) == nil
                        expect(result.chooseOne) == [
                            .apply(.chooseCard(player: .id("p1"), card: .id("c1")), ctx: ctx),
                            .apply(.chooseCard(player: .id("p1"), card: .id("c2")), ctx: ctx),
                        ]
                    }
                }

                context("single card remaining") {
                    it("should draw card immediately") {
                        // Given
                        // When
                        // Then
                    }
                }

                context("no card available") {
                    it("should throw error") {
                        // Given
                        let state = GameState()

                        // When
                        // Then
                        let effect = CardEffect.chooseCard(player: .id("p1"), card: .selectChoosable)
                        expect(try sut(effect, state, ctx))
                            .to(throwError(GameError.noChoosableCard))
                    }
                }
            }

            context("specified id") {
                it("should draw card immediately") {
                    // Given
                    // When
                    // Then
                }
            }
        }
    }
}
