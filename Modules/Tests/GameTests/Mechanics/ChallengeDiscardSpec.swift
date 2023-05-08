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
                it("should ask to choose card or pass and reverse challenge") {
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
                    let reversedCtx = EffectContext(actor: "px", card: "cx", target: "px")
                    expect(result.queue.first) == .chooseAction(chooser: "p1", options: [
                        "counter": GameAction.group {
                            GameAction.discard(player: "p1", card: "counter")
                            CardEffect.challengeDiscard(player: .id("px"),
                                                        card: .selectHandNamed("counter"),
                                                        otherwise: .damage(1, player: .target),
                                                        challenger: .id("p1")).withCtx(reversedCtx)
                        },
                        .pass: CardEffect.damage(1, player: .target).withCtx(ctx)
                    ])
                }
            }
        }
    }
}
