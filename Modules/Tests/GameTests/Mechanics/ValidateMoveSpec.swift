//
//  ValidateMoveSpec.swift
//  
//
//  Created by Hugues Stephano TELOLAHY on 12/05/2023.
//

import XCTest
@testable import Game

final class ValidateMoveSpec: XCTestCase {
    
    let beer = Card("beer") {
        CardEffect.heal(1, player: .actor)
            .triggered(on: .play)
    }

    func test_ValidAction() throws {
        // Given
        let state = GameState {
            Player("p1") {
                Hand {
                    "beer"
                }
            }
            .attribute(.health, 1)
            .attribute(.maxHealth, 4)
        }
        .cardRef(["beer": beer])
        
        // When
        let action = GameAction.play(actor: "p1", card: "beer")
        let isValid =  try action.isValid(state)
        
        // Then
        XCTAssertEqual(isValid, true)
    }
    
    func test_InvalidAction() throws {
        // Given
        let state = GameState {
            Player("p1") {
                Hand {
                    "beer"
                }
            }
            .attribute(.health, 4)
            .attribute(.maxHealth, 4)
        }
        .cardRef(["playable": beer])
        
        // When
        let action = GameAction.play(actor: "p1", card: "beer")
        
        // Then
        XCTAssertThrowsError(try action.isValid(state)) { error in
            XCTAssertEqual(error as? GameError, .playerAlreadyMaxHealth("p1"))
        }
    }
}
