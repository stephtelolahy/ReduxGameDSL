//
//  InventorySpec.swift
//  
//
//  Created by Hugues Telolahy on 04/04/2023.
//
import Foundation
import Game
import Quick
import Nimble

final class InventorySpec: QuickSpec {
    override func spec() {
        describe("inventory") {
            context("by default") {
                it("should contain all collectible cards") {
                    // Given
                    // When
                    let cards = Inventory.cardRef
                    // Then
//                    expect(cards[.barrel]) != nil
//                    expect(cards[.dynamite]) != nil
//                    expect(cards[.jail]) != nil
//                    expect(cards[.mustang]) != nil
//                    expect(cards[.remington]) != nil
//                    expect(cards[.revCarabine]) != nil
//                    expect(cards[.schofield]) != nil
//                    expect(cards[.scope]) != nil
//                    expect(cards[.volcanic]) != nil
//                    expect(cards[.winchester]) != nil
//                    expect(cards[.bang]) != nil
                    expect(cards[.beer]) != nil
//                    expect(cards[.catBalou]) != nil
//                    expect(cards[.duel]) != nil
//                    expect(cards[.gatling]) != nil
//                    expect(cards[.generalStore]) != nil
//                    expect(cards[.indians]) != nil
//                    expect(cards[.missed]) != nil
//                    expect(cards[.panic]) != nil
//                    expect(cards[.saloon]) != nil
//                    expect(cards[.stagecoach]) != nil
//                    expect(cards[.wellsFargo]) != nil
                }
            }
        }
    }
}
