//
//  ValidateActionSpec.swift
//  
//
//  Created by Hugues Stephano TELOLAHY on 12/05/2023.
//

import XCTest
@testable import Game

final class ValidateActionSpec: XCTestCase {
    
    private let beer = Card("beer") {
        CardEffect.heal(1, player: .actor)
            .triggered(.onPlay)
    }

    func test_GivenPlayAction_WhenDispatchingRecursivelySucceed_ThenShouldBeValid() throws {
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
        
        // Then
        XCTAssertNoThrow(try action.validate(state: state))
    }
    
    func test_GivenPlayAction_WhenDispatchingRecursivelyFails_ThenShouldBeInvalid() throws {
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
            .cardRef(["beer": beer])
        
        // When
        let action = GameAction.play(actor: "p1", card: "beer")
        
        // Then
        XCTAssertThrowsError(try action.validate(state: state)) { error in
            XCTAssertEqual(error as? GameError, .playerAlreadyMaxHealth("p1"))
        }
    }

    func test_GivenChooseAction_WhenAllOptionsSucceed_ThenShouldBeValid() throws {
        // Given
        let state = GameState {
            Player("p1")
        }

        // When
        let action = GameAction.chooseAction(chooser: "p1", options: [
            "option1": .damage(player: "p1", value: 1),
            "option2": .damage(player: "p1", value: 2)
        ])

        // Then
        XCTAssertNoThrow(try action.validate(state: state))
    }

    func test_GivenChooseAction_WhenAnyOptionFails_ThenShouldBeInvalid() throws {
        // Given
        let state = GameState {
            Player("p1")
                .attribute(.health, 4)
                .attribute(.maxHealth, 4)
        }

        // When
        let action = GameAction.chooseAction(chooser: "p1", options: [
            "option1": .damage(player: "p1", value: 1),
            "option2": .heal(player: "p1", value: 1)
        ])

        // Then
        XCTAssertThrowsError(try action.validate(state: state)) { error in
            XCTAssertEqual(error as? GameError, .playerAlreadyMaxHealth("p1"))
        }
    }
}
