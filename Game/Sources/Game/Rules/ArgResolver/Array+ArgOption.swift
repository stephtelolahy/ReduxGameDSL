//
//  Array+ArgOption.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

extension Array where Element == String {
    func toOptions() -> [ArgOption] {
        map { ArgOption(id: $0, label: $0) }
    }
}
