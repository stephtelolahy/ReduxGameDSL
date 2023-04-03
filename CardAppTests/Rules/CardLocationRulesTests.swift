////
////  CardLocationRulesTests.swift
////  CardAppTests
////
////  Created by Hugues Telolahy on 02/04/2023.
////
//import Game
//import XCTest
//
//final class CardLocationRulesTests: XCTestCase {
//
//    func test_AddCardWhenEmpty() {
//        // Given
//        var sut = CardLocation()
//
//        // When
//        sut.add(Card("c1"))
//
//        // Assert
//        XCTAssertEqual(sut.cards.map(\.id), ["c1"])
//    }
//
//    func test_AddCardWhenNotEmpty() {
//        // Given
//        var sut = CardLocation {
//            Card("c1")
//        }
//
//        // When
//        sut.add(Card("c2"))
//
//        // Assert
//        XCTAssertEqual(sut.cards.map(\.id), ["c1", "c2"])
//    }
//
//    func test_SearchById() {
//        // Given
//        let sut = CardLocation {
//            Card("c1")
//            Card("c2")
//        }
//
//        // When
//        // Assert
//        XCTAssertNil(sut.search(byId: "c3"))
//        XCTAssertNotNil(sut.search(byId: "c1"))
//        XCTAssertNotNil(sut.search(byId: "c2"))
//    }
//
//    func test_RemoveById() {
//        // Given
//        var sut = CardLocation {
//            Card("c1")
//            Card("c2")
//        }
//
//        // When
//        let result = sut.remove(byId: "c1")
//
//        // Assert
//        XCTAssertEqual(result.id, "c1")
//        XCTAssertEqual(sut.count, 1)
//        XCTAssertEqual(sut.cards.map(\.id), ["c2"])
//    }
//}
