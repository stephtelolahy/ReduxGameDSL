//
//  PlayReqMatcherProtocol.swift
//  
//
//  Created by Hugues Telolahy on 13/04/2023.
//

protocol PlayReqMatcherProtocol {
    func match(state: GameState, ctx: PlayContext) throws
}
