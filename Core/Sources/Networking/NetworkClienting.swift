//
//  File.swift
//  
//
//  Created by Philip on 27.10.2023.
//

import Foundation

public protocol NetworkClienting {
    func execute<Response: Decodable>(request: URLRequest) async throws -> Response
}
