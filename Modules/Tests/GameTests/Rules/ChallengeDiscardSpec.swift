//
//  ChallengeDiscardSpec.swift
//  
//
//  Created by Hugues Telolahy on 23/04/2023.
//

@testable import Game
import Quick
import Nimble

final class ChallengeDiscardSpec: QuickSpec {
    override func spec() {
        let sut = GameReducer()
        let ctx = EffectContext(actor: "px", card: "cx", target: "p1")
        
        describe("challenge discard") {
            context("having required card") {
                it("should ask to choose card or pass") {
                    // Given
                    let state = GameState {
                        Player("p1") {
                            Hand {
                                "counter"
                            }
                        }
                    }
                    
                    // When
                    let action = CardEffect.challengeDiscard(player: .id("p1"),
                                                             card: .selectHandNamed("counter"),
                                                             otherwise: .damage(1, player: .target),
                                                             challenger: .id("px")).withCtx(ctx)
                    let result = sut.reduce(state: state, action: action)
                    
                    // Then
                    expect(result.queue.first) == .chooseOne(chooser: "p1", options: [
                        "counter": CardEffect.group {
                            CardEffect.discard(player: .id("p1"), card: .id("counter"))
                            CardEffect.challengeDiscard(player: .id("px"),
                                                        card: .selectHandNamed("counter"),
                                                        otherwise: .damage(1, player: .target),
                                                        challenger: .id("p1"))
                        }.withCtx(EffectContext(actor: "px", card: "cx", target: "px")),
                        .pass: CardEffect.damage(1, player: .target).withCtx(ctx)
                    ])
                }
            }
        }
    }
}
