//
//  ChooseOne.swift
//  
//
//  Created by Hugues Telolahy on 22/04/2023.
//

/// Pending actions to choose before continuing effect resolving
public struct ChooseOne: Equatable, Codable {

    /// Actror
    public let chooser: String

    /// Expected actions
    public let options: [String: GameAction]

    public init(chooser: String, options: [String: GameAction]) {
        self.chooser = chooser
        self.options = options
    }
}

/// ChooseOne labels
public extension String {

    /// Random hand card label
    static let randomHand = "randomHand"

    /// Pass when asked to do an action
    static let pass = "pass"
}
