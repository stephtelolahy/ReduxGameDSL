//
//  GatlingSpec.swift
//  
//
//  Created by Hugues Telolahy on 22/04/2023.
//

import Quick
import Nimble
import Game

final class GatlingSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        describe("playing gatling") {
            context("three players") {
                it("should allow each player to counter or pass") {
                    // Given
                    let state = GameState {
                        Player("p1") {
                            Hand {
                                .gatling
                            }
                        }
                        Player("p2") {
                            Hand {
                                .missed
                            }
                        }

                        Player("p3")
                    }
                    let sut = createGameStore(initial: state)

                    // When
                    var action = GameAction.play(actor: "p1", card: .gatling)
                    var result = self.awaitAction(action, store: sut)

                    // Then
                    let ctx = EffectContext(actor: "p1", card: .gatling)
                    let ctxP2 = EffectContext(actor: "p1", card: .gatling, target: "p2")
                    let ctxP3 = EffectContext(actor: "p1", card: .gatling, target: "p3")

                    expect(result) == [.success(.play(actor: "p1", card: .gatling))]
                    expect(sut.state.chooseOne) == ChooseOne(chooser: "p2", options: [
                        .missed: .apply(.discard(player: .id("p2"), card: .id(.missed)), ctx: ctxP2),
                        Label.pass: .apply(.damage(1, player: .target), ctx: ctxP2)
                    ])

                    // When p2 counter
                    action = .apply(.discard(player: .id("p2"), card: .id(.missed)), ctx: ctxP2)
                    result = self.awaitAction(action, store: sut)

                    // Then
                    expect(result) == [
                        .success(.apply(.discard(player: .id("p2"), card: .id(.missed)), ctx: ctxP2))
                    ]
                    expect(sut.state.chooseOne) == ChooseOne(chooser: "p3", options: [
                        Label.pass: .apply(.damage(1, player: .target), ctx: ctxP3)
                    ])

                    // When p3 pass
                    action = .apply(.damage(1, player: .target), ctx: ctxP3)
                    result = self.awaitAction(action, store: sut)

                    // Then
                    expect(result) == [
                        .success(.apply(.damage(1, player: .id("p3")), ctx: ctxP3))
                    ]
                    expect(sut.state.chooseOne) == nil
                }
            }

            xcontext("two players") {
                it("should allow each player to counter") {
                    // Given
                    // When
                    // Then
                }
            }
        }
    }
}
