//
//  GeneralStoreSpec.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

import Quick
import Nimble
import Game
import Inventory

final class GeneralStoreSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        describe("playing generalStore") {
            context("three players") {
                it("should allow each player to choose a card") {
                    // Given
                    let state = createGame {
                        Player("p1") {
                            Hand {
                                .generalStore
                            }
                        }
                        Player("p2")
                        Player("p3")
                        Deck {
                            "c1"
                            "c2"
                            "c3"
                        }
                    }
                    let sut = createGameStore(initial: state)
                    
                    // When
                    var action = GameAction.play(actor: "p1", card: .generalStore)
                    var result = self.awaitAction(action, store: sut)
                    
                    // Then
                    let ctx = EffectContext(actor: "p1", card: .generalStore)
                    expect(result) == [.success(.play(actor: "p1", card: .generalStore)),
                                       .success(.reveal),
                                       .success(.reveal),
                                       .success(.reveal)]
                    expect(sut.state.chooseOne) == ChooseOne(chooser: "p1", options: [
                        "c1": .chooseCard(player: .id("p1"), card: .id("c1"), ctx: ctx),
                        "c2": .chooseCard(player: .id("p1"), card: .id("c2"), ctx: ctx),
                        "c3": .chooseCard(player: .id("p1"), card: .id("c3"), ctx: ctx)
                    ])
                    
                    // When p1 choose
                    action = .chooseCard(player: .id("p1"), card: .id("c1"), ctx: ctx)
                    result = self.awaitAction(action, store: sut)
                    
                    // Then
                    expect(result) == [
                        .success(.chooseCard(player: .id("p1"), card: .id("c1")))
                    ]
                    expect(sut.state.chooseOne) == ChooseOne(chooser: "p1", options: [
                        "c2": .chooseCard(player: .id("p2"), card: .id("c2"), ctx: ctx),
                        "c3": .chooseCard(player: .id("p2"), card: .id("c3"), ctx: ctx)
                    ])
                    
                    // When p2 choose
                    action = .chooseCard(player: .id("p2"), card: .id("c2"), ctx: ctx)
                    result = self.awaitAction(action, store: sut)
                    
                    // Then
                    expect(result) == [
                        .success(.chooseCard(player: .id("p2"), card: .id("c2"))),
                        .success(.chooseCard(player: .id("p3"), card: .id("c3")))
                    ]
                    expect(sut.state.chooseOne) == nil
                }
            }
            
            context("two players") {
                it("should allow each player to choose a card") {
                    // Given
                    let state = createGame {
                        Player("p1") {
                            Hand {
                                .generalStore
                            }
                        }
                        Player("p2")
                        Deck {
                            "c1"
                            "c2"
                        }
                    }
                    let sut = createGameStore(initial: state)
                    
                    // When
                    var action = GameAction.play(actor: "p1", card: .generalStore)
                    var result = self.awaitAction(action, store: sut)
                    
                    // Then
                    let ctx = EffectContext(actor: "p1", card: .generalStore)
                    expect(result) == [.success(.play(actor: "p1", card: .generalStore)),
                                       .success(.reveal),
                                       .success(.reveal)]
                    expect(sut.state.chooseOne) == ChooseOne(chooser: "p1", options: [
                        "c1": .chooseCard(player: .id("p1"), card: .id("c1"), ctx: ctx),
                        "c2": .chooseCard(player: .id("p1"), card: .id("c2"), ctx: ctx)
                    ])
                    
                    // When p1 choose
                    action = .chooseCard(player: .id("p1"), card: .id("c1"), ctx: ctx)
                    result = self.awaitAction(action, store: sut)
                    
                    // Then
                    expect(result) == [
                        .success(.chooseCard(player: .id("p1"), card: .id("c1"))),
                        .success(.chooseCard(player: .id("p2"), card: .id("c2")))
                    ]
                    expect(sut.state.chooseOne) == nil
                }
            }
        }
    }
}
