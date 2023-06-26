//
//  DynamiteSpec.swift
//  
//
//  Created by Hugues Stephano TELOLAHY on 26/06/2023.
//

import Quick
import Nimble
import Game

final class DynamiteSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        describe("playing dynamite") {
            it("should target") {
                // Given
                let state = createGame {
                    Player("p1") {
                        Hand {
                            .dynamite
                        }
                    }
                }
                
                // When
                let action = GameAction.play(.dynamite, actor: "p1")
                let result = self.awaitAction(action, state: state)
                
                // Then
                expect(result) == [
                    .success(.playEquipment(.dynamite, actor: "p1"))
                ]
            }
        }
    }
}

