//
//  GameSpec.swift
//  
//
//  Created by Hugues Telolahy on 08/04/2023.
//

import Quick
import Nimble
import Game

final class GameSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        describe("a Game") {
            var sut: GameState!
            context("by default") {
                beforeEach {
                    sut = GameState()
                }
                
                it("should have empty deck") {
                    expect(sut.deck.count) == 0
                }
                
                it("should have empty discard") {
                    expect(sut.discard.count) == 0
                }
                
                it("should not have choosable") {
                    expect(sut.choosable) == nil
                }
                
                it("should not be over") {
                    expect(sut.isOver) == false
                }
                
                it("should not have turn") {
                    expect(sut.turn) == nil
                }
                
                it("should have empty players") {
                    expect(sut.players).to(beEmpty())
                }
            }
            
            context("initialized with deck") {
                it("should have deck cards") {
                    // Given
                    // When
                    let sut = GameState {
                        Deck {
                            "c1"
                            "c2"
                        }
                    }
                    
                    // Then
                    expect(sut.deck.count) == 2
                }
            }
            
            context("initialized with discard pile") {
                it("should have discarded cards") {
                    // Given
                    // When
                    let sut = GameState {
                        DiscardPile {
                            "c1"
                            "c2"
                        }
                    }
                    
                    // Then
                    expect(sut.discard.count) == 2
                }
            }
            
            context("initialized with choosable") {
                it("should have choosable cards") {
                    // Given
                    // When
                    let sut = GameState {
                        Choosable {
                            "c1"
                            "c2"
                        }
                    }
                    
                    // Then
                    expect(sut.choosable?.cards) == ["c1", "c2"]
                }
            }
            
            context("modified game over") {
                it("should be over") {
                    // Given
                    // When
                    let sut = GameState().isOver(true)
                    
                    // Then
                    expect(sut.isOver) == true
                }
            }
            
            context("modified turn") {
                it("should have turn") {
                    // Given
                    // When
                    let sut = GameState().turn("p1")
                    
                    // Then
                    expect(sut.turn) == "p1"
                }
            }
            
            context("initialized with players") {
                it("should have players") {
                    // Given
                    // When
                    let sut = GameState {
                        Player("p1")
                        Player("p2")
                    }
                    
                    // Then
                    expect(sut.players.map(\.id)) == ["p1", "p2"]
                }
            }
        }
    }
}
