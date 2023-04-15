//
//  ArgOutput.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

/// Resolved argument
enum ArgOutput {
    /// Appply effect to well known object identifiers
    case identified([String])
    
    /// Must choose one of given object identifiers
    case selectable([ArgOption])
}

/// Selectable argument option
struct ArgOption {
    
    /// Identifier
    let id: String
    
    /// Displayed label
    let label: String
}

extension Array where Element == String {
    func toOptions() -> [ArgOption] {
        map { ArgOption(id: $0, label: $0) }
    }
}
