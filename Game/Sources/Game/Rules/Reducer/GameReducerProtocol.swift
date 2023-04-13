//
//  GameReducerProtocol.swift
//  
//
//  Created by Hugues Telolahy on 13/04/2023.
//

protocol GameReducerProtocol {
    func reduce(_ state: GameState) throws -> GameState
}
