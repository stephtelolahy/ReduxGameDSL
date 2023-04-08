//
//  CardLocationSpec.swift
//  
//
//  Created by Hugues Telolahy on 08/04/2023.
//

import Quick
import Nimble
import Game

final class CardLocationSpec: QuickSpec {
    override func spec() {
        describe("a card location") {
            var sut: CardLocation!
            context("by default") {
                beforeEach {
                    sut = CardLocation()
                }
                
                it("should be empty") {
                    expect(sut.cards).to(beEmpty())
                }
                
                it("should be visible to everyone") {
                    expect(sut.visibility) == nil
                }
            }
            
            context("initialized with visibility") {
                it("should have limited visibility") {
                    // Given
                    // When
                    let sut = CardLocation(visibility: "p1")
                    
                    // Then
                    expect(sut.visibility) == "p1"
                }
            }
            
            context("initialized with cards") {
                it("should have correct count") {
                    // Given
                    // When
                    let sut = CardLocation {
                        "c1"
                    }
                    
                    // Then
                    expect(sut.count) == 1
                }
                
                it("should have cards") {
                    // Given
                    // When
                    let sut = CardLocation {
                        "c1"
                        "c2"
                    }
                    
                    // Then
                    expect(sut.cards) == ["c1", "c2"]
                }
            }
        }
    }
}
