//
//  CodableResult.swift
//  
//
//  Created by Hugues Telolahy on 29/04/2023.
//

public typealias EquatableCodable = Equatable & Codable

public enum CodableResult<T: EquatableCodable, E: Error & EquatableCodable>: EquatableCodable {
    case success(T)
    case failure(E)
}
