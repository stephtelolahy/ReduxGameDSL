//
//  ChallengeDiscardSpec.swift
//  
//
//  Created by Hugues Telolahy on 23/04/2023.
//

import Quick
import Nimble
@testable import Game

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
                                .missed
                            }
                        }
                    }
                    
                    // When
                    let action = GameAction.challengeDiscard(player: .id("p1"),
                                                             card: .selectHandNamed(.missed),
                                                             otherwise: .damage(1, player: .target),
                                                             challenger: .id("px"), ctx: ctx)
                    let result = sut.reduce(state: state, action: action)
                    
                    // Then
                    expect(result.chooseOne) == ChooseOne(chooser: "p1", options: [
                        .missed: .discard(player: .id("p1"), card: .id(.missed), ctx: ctx),
                        .pass: .damage(1, player: .target, ctx: ctx)
                    ])
                }
            }
        }
    }
}
