//
//  FatalError.swift
//  
//
//  Created by Hugues Telolahy on 08/04/2023.
//

func fatalError(_ error: FatalError, file: StaticString = #file, line: UInt = #line) -> Never {
    fatalError(String(describing: error), file: file, line: line)
}

enum FatalError: Error {

    /// Expected a player with given identifier
    case playerNotFound(String)

    /// Any unexpected error
    case unexpected
}
