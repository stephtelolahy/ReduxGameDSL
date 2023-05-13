//
//   Card+Updating.swift
//  
//
//  Created by Hugues Telolahy on 12/05/2023.
//

extension CardAction {
    var isImmediate: Bool {
        if case .immediately = self.actionType {
            return true
        }
        return false
    }
}
