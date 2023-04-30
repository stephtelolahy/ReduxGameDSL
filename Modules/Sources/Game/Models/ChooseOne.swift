//
//  ChooseOne.swift
//  
//
//  Created by Hugues Telolahy on 30/04/2023.
//

public struct ChooseOne: Codable, Equatable {
    public let chooser: String
    public let options: [String: GameAction]
}
