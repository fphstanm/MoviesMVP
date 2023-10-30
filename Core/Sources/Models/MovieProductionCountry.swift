//
//  File.swift
//  
//
//  Created by Philip on 30.10.2023.
//

import Foundation

public struct MovieProductionCountry: Equatable {

    public let code: String
    public let name: String

    public init(code: String, name: String) {
        self.code = code
        self.name = name
    }
}
