////
////  GameEventTests.swift
////  
////
////  Created by Hugues Telolahy on 29/03/2023.
////
//import XCTest
//
//final class GameEventTests: XCTestCase {
//
//    func test_InitialEventIsNil() {
//        // Given
//        let sut = Game()
//
//        // When
//        // Assert
//        XCTAssertNil(sut.event)
//    }
//
//    func test_GetLastEvent() {
//        // Given
//        let sut = Game {
//            LastEvent(.failure(SomeError()))
//        }
//
//        // When
//        // Assert
//        guard case let .failure(error) = sut.event,
//              error is SomeError else {
//            XCTFail("Invalid last event")
//            return
//        }
//    }
//}
//
//struct SomeError: Error, Equatable {}
