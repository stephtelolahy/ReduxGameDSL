//
//  ChooseOne.swift
//  
//
//  Created by Hugues Telolahy on 30/04/2023.
//

/// Ask a player to choose an action
public struct ChooseOne: Codable, Equatable {
    public let chooser: String
    public let options: [String: GameAction]
}

/// ChooseOne labels
public extension String {

    /// Random hand card label
    static let randomHand = "randomHand"

    /// Pass when asked to do an action
    static let pass = "pass"
}
