//
//  GameError+FatalError.swift
//  
//
//  Created by Hugues Telolahy on 08/04/2023.
//

func fatalError(_ error: GameError, file: StaticString = #file, line: UInt = #line) -> Never {
    fatalError(String(describing: error), file: file, line: line)
}
