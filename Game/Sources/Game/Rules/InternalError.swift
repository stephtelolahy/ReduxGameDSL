//
//  InternalError.swift
//  
//
//  Created by Hugues Telolahy on 07/04/2023.
//

/// Fatal game errors
enum InternalError: Error {
    case missingPlayer(String)
    case missingCard(String)
}

func fatalError(_ error: Error, file: StaticString = #file, line: UInt = #line) -> Never {
    fatalError(String(describing: error), file: file, line: line)
}
