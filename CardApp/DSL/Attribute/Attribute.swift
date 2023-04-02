//
//  Attribute.swift
//  
//
//  Created by Hugues Telolahy on 25/03/2023.
//

/// Temporary structure allowing element initizalization using DSL
protocol Attribute {
    associatedtype Value
    var value: Value { get }
}
