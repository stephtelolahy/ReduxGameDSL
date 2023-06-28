//
//  EventLoggerMiddlewareTests.swift
//  
//
//  Created by Hugues Stephano TELOLAHY on 27/06/2023.
//

import XCTest
import Game

final class EventLoggerMiddlewareTests: XCTestCase {

    func testRemovingPackageName() {
        XCTAssertEqual(GameAction.cancel.loggerDescription, "cancel")
    }
}
