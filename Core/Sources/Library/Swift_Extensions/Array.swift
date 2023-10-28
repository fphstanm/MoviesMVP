//
//  File.swift
//  
//
//  Created by Philip on 27.10.2023.
//

import Foundation

public extension Array {
    mutating func update(with worker: (inout Element) -> Void) {
        for index in self.indices {
            worker(&self[index])
        }
    }
}
