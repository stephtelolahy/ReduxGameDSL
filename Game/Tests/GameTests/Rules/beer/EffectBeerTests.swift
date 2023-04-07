//
//  EffectBeerTests.swift
//  
//
//  Created by Hugues Telolahy on 08/04/2023.
//

import XCTest
import Game

final class EffectBeerTests: XCTestCase {

    private let sut = cardEffectMiddleware

    func test_GainHealth_IfPlayingBeer() throws {
        // Given
        let ctx = GameState()
        let action = GameAction.play(actor: "p1", card: "beer-6♥️")

        // When
        let result = try awaitPublisher(sut(ctx, action))

        // Assert
        XCTAssertEqual(result, .apply(.heal(1, player: .id("p1"))))
    }
}
