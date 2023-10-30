//
//  File.swift
//  
//
//  Created by Philip on 27.10.2023.
//

import Foundation

public struct AppRequest {
    public enum Method: String {
        case get = "GET"
        case post = "POST"
    }

    let baseUrl: URL
    private(set) var method: Method
    private(set) var headers: [String: String]?
    private(set) var path: String
    private(set) var query: [String: String]?
    private(set) var body: Encodable?

    init(baseUrl: URL) {
        self.baseUrl = baseUrl
        self.method = .get
        self.headers = nil
        self.path = ""
        self.query = nil
        self.body = nil
    }

    // MARK: - Public methods

    public func add(method: Method) -> Self {
        map { $0.method = method }
    }

    public func add(headers: [String: String]) -> Self {
        map { $0.headers = headers }
    }

    public func add(path: String) -> Self {
        map { $0.path = path }
    }

    public func add(query: [String: String]) -> Self {
        map { $0.query = query }
    }

    public func add<Body: Encodable>(body: Body) -> Self {
        map { $0.body = body }
    }

    // MARK: - Private methods

    private func map(_ transform: (inout Self) -> ()) -> Self {
        var request = self
        transform(&request)
        return request
    }
}
