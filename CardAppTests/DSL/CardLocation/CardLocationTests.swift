////
////  CardLocationTests.swift
////  
////
////  Created by Hugues Telolahy on 26/03/2023.
////
//import XCTest
//
//final class CardLocationTests: XCTestCase {
//
//    func test_CardsCountIsZero_WhenInitialized() {
//        // Given
//        let sut = CardLocation()
//
//        // When
//        // Assert
//        XCTAssertEqual(sut.count, 0)
//    }
//
//    func test_CardsCountIsOne_WhenInitializedWithOneCard() {
//        // Given
//        let sut = CardLocation {
//            Card()
//        }
//
//        // When
//        // Assert
//        XCTAssertEqual(sut.count, 1)
//    }
//
//    func test_CardsContent() {
//        // Given
//        let sut = CardLocation {
//            Card("c1")
//            "c2"
//            "c3"
//        }
//
//        // When
//        // Assert
//        XCTAssertEqual(sut.cards.map(\.id), ["c1", "c2", "c3"])
//    }
//
//    func test_VisibilityIsPublic_ByDefault() {
//        // Given
//        let sut = CardLocation()
//
//        // When
//        // Assert
//        XCTAssertNil(sut.visibility)
//    }
//
//    func test_VisibilityIsRestricted_AtInit() {
//        // Given
//        let sut = CardLocation(visibility: "p1")
//
//        // When
//        // Assert
//        XCTAssertEqual(sut.visibility, "p1")
//    }
//
//    func test_AddCardWhenEmpty() {
//        // Given
//        var sut = CardLocation()
//
//        // When
//        sut.add(Card("c1"))
//
//        // Assert
//        XCTAssertEqual(sut.content.map(\.id), ["c1"])
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
