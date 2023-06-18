//
//  BarrelTests.swift
//  
//
//  Created by Hugues Telolahy on 18/06/2023.
//

import Quick
import Nimble
import Game

final class BarrelSpec: QuickSpec {
    override func spec() {
        describe("playing barrel") {
            it("should equip") {
                // Given
                let state = createGame {
                    Player("p1") {
                        Hand {
                            .barrel
                        }
                    }
                }

                // When
                let action = GameAction.play(actor: "p1", card: .barrel)
                let result = self.awaitAction(action, state: state)

                // Then
                expect(result) == [.success(.playEquipment(actor: "p1", card: .barrel))]
            }
        }
        
        xdescribe("triggering barrel") {
            it("should counter bang effect") {
                
            }
        }
    }
}
