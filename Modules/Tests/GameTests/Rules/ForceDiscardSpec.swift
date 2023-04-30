//
//  ForceDiscardSpec.swift
//  
//
//  Created by Hugues Telolahy on 16/04/2023.
//

@testable import Game
import Quick
import Nimble

final class ForceDiscardSpec: QuickSpec {
    override func spec() {
        let sut = GameReducer()
        let ctx = EffectContext(actor: "px", card: "cx", target: "p1")

        describe("force discard") {
            context("having required card") {
                it("should ask to choose card or pass") {
                    // Given
                    let state = GameState {
                        Player("p1") {
                            Hand {
                                "counter-10♣️"
                                "counter-8♠️"
                            }
                        }
                    }

                    // When
                    let action = CardEffect.forceDiscard(player: .id("p1"),
                                                         card: .selectHandNamed("counter"),
                                                         otherwise: .damage(1, player: .target)).withCtx(ctx)
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.chooseOne) == ChooseOne(chooser: "p1", options: [
                        "counter-10♣️": CardEffect.discard(player: .id("p1"), card: .id("counter-10♣️")).withCtx(ctx),
                        "counter-8♠️": CardEffect.discard(player: .id("p1"), card: .id("counter-8♠️")).withCtx(ctx),
                        .pass: CardEffect.damage(1, player: .target).withCtx(ctx)
                    ])
                }
            }

            context("not having required card") {
                it("should ask to pass") {
                    // Given
                    let state = GameState {
                        Player("p1")
                    }

                    // When
                    let action = CardEffect.forceDiscard(player: .id("p1"),
                                                         card: .selectHandNamed("counter"),
                                                         otherwise: .damage(1, player: .target)).withCtx(ctx)
                    let result = sut.reduce(state: state, action: action)

                    // Then
                    expect(result.chooseOne) == ChooseOne(chooser: "p1", options: [
                        .pass: CardEffect.damage(1, player: .target).withCtx(ctx)
                    ])
                }
            }
        }
    }
}
