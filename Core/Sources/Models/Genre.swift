//
//  File.swift
//  
//
//  Created by Philip on 27.10.2023.
//

import Foundation

public struct Genre: Equatable {

    public let id: Int
    public var name: String

    // MARK: - Lifecycle

    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
