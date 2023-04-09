//
//  ArgResolver.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

typealias ArgResolver = (ArgPlayer, GameState, PlayContext) -> Result<ArgOutput, GameError>

/// Resolved argument
enum ArgOutput {
    /// appply effect to well known object identifiers
    case identified([String])

    /// must choose one of given object identifiers
    case selectable([ArgOption])
}

/// Selectable argument option
struct ArgOption {

    /// identifier
    let id: String

    /// displayed label
    let label: String
}

let argResolver: ArgResolver
= { arg, state, ctx in
        .success(.identified([]))
}
