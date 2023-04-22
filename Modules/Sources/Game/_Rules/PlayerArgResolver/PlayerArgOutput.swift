//
//  PlayerArgOutput.swift
//  
//
//  Created by Hugues Telolahy on 16/04/2023.
//

/// Resolved player argument
enum PlayerArgOutput {
    /// Appply effect to well known object identifiers
    case identified([String])

    /// Must choose one of given object identifiers
    case selectable([String])
}
