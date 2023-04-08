//
//  CardSpec.swift
//  
//
//  Created by Hugues Telolahy on 08/04/2023.
//

import Quick
import Nimble
import Game

final class CardSpec: QuickSpec {
    override func spec() {
        describe("a card") {
            var sut: Card!
            context("initialized") {
                beforeEach {
                    sut = Card("c1")
                }
                
                it("should have a name") {
                    expect(sut.name) == "c1"
                }
            }
        }
    }
}
