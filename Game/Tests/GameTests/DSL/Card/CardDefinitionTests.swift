//
//  CardDefinitionTests.swift
//  
//
//  Created by Hugues Telolahy on 03/04/2023.
//
import Game
import XCTest

final class CardDefinitionTests: XCTestCase {

    func test_DefineBeerCard() {
        // Given
        let beer = Card {
            CardEffect.heal(1, player: .actor)
                .onPlay {
                    PlayReq.isPlayersAtLeast(3)
                }
        }

        // When
        // Assert
        XCTAssertEqual(beer.actions.count, 1)
    }
}
