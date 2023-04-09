//
//  Result+Extensions.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

public extension Result where Success == Void {
    static var success: Result { .success(()) }
}

public extension Result {

    var isSuccess: Bool {
        if case .success = self {
            return true
        } else {
            return false
        }
    }

    var isFailure: Bool {
        !isSuccess
    }
}
