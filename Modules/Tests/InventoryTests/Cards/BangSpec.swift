//
//  BangSpec.swift
//  
//
//  Created by Hugues Telolahy on 16/04/2023.
//

import Game
import Quick
import Nimble
import Inventory

final class BangSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        describe("playing bang") {
            context("reached limit per turn") {
                it("should throw error") {
                    // Given
                    let state = createGame {
                        Player("p1") {
                            Hand {
                                .bang
                            }
                        }
                    }
                    .counters([.bang: 1])
                    
                    let sut = createGameStore(initial: state)
                    
                    // When
                    let action = GameAction.play(actor: "p1", card: .bang)
                    let result = self.awaitAction(action, store: sut)
                    
                    // Assert
                    expect(result) == [.failure(.reachedLimitPerTurn(1))]
                }
            }
            
            context("without target") {
                context("no player reachable") {
                    it("should throw error") {
                        // Given
                        let state = createGame {
                            Player("p1") {
                                Hand {
                                    .bang
                                }
                            }
                            Player("p2").mustang(1)
                            Player("p3")
                            Player("p4").mustang(1)
                        }
                        let sut = createGameStore(initial: state)
                        
                        // When
                        let action = GameAction.play(actor: "p1", card: .bang)
                        let result = self.awaitAction(action, store: sut)
                        
                        // Then
                        expect(result) == [.failure(GameError.noPlayerAtRange(1))]
                    }
                }
                
                context("some player reachable") {
                    it("should choose a target") {
                        // Given
                        let state = createGame {
                            Player("p1") {
                                Hand {
                                    .bang
                                }
                            }
                            Player("p2")
                            Player("p3")
                            Player("p4")
                        }
                        let sut = createGameStore(initial: state)
                        
                        // When
                        let action = GameAction.play(actor: "p1", card: .bang)
                        let result = self.awaitAction(action, store: sut)
                        
                        // Then
                        expect(result).to(beEmpty())
                        expect(sut.state.chooseOne) == ChooseOne(chooser: "p1", options: [
                            "p2": .play(actor: "p1", card: .bang, target: "p2"),
                            "p4": .play(actor: "p1", card: .bang, target: "p4")
                        ])
                    }
                }
            }
            
            context("with target") {
                context("having missed") {
                    it("should ask to counter or pass") {
                        // Given
                        let state = createGame {
                            Player("p1") {
                                Hand {
                                    .bang
                                }
                            }
                            Player("p2") {
                                Hand {
                                    .missed
                                }
                            }
                        }
                        let sut = createGameStore(initial: state)
                        
                        // When
                        let action = GameAction.play(actor: "p1", card: .bang, target: "p2")
                        let result = self.awaitAction(action, store: sut)
                        
                        // Then
                        expect(result) == [.success(.play(actor: "p1", card: .bang, target: "p2"))]
                        let ctx = EffectContext(actor: "p1", card: .bang, target: "p2")
                        expect(sut.state.chooseOne) == ChooseOne(chooser: "p2", options: [
                            .missed: .discard(player: .id("p2"), card: .id(.missed), ctx: ctx),
                            .pass: .damage(1, player: .target, ctx: ctx)
                        ])
                        
                        // TODO: 
                        expect(sut.state.chooseOne) == nil
                    }
                }
                
                context("not having missed") {
                    it("should ask to pass only") {
                        // Given
                        let state = createGame {
                            Player("p1") {
                                Hand {
                                    .bang
                                }
                            }
                            Player("p2")
                        }
                        let sut = createGameStore(initial: state)
                        
                        // When
                        let action = GameAction.play(actor: "p1", card: .bang, target: "p2")
                        let result = self.awaitAction(action, store: sut)
                        
                        // Then
                        expect(result) == [.success(.play(actor: "p1", card: .bang, target: "p2"))]
                        let ctx = EffectContext(actor: "p1", card: .bang, target: "p2")
                        expect(sut.state.chooseOne) == ChooseOne(chooser: "p2", options: [
                            .pass: .damage(1, player: .target, ctx: ctx)
                        ])
                        
                        // TODO: 
                        expect(sut.state.chooseOne) == nil
                    }
                }
            }
        }
    }
}
