//
//  File.swift
//  
//
//  Created by Philip on 27.10.2023.
//

import Foundation

extension AppRequest {
    func asUrlRequest() throws -> URLRequest {
        guard
            let url = URL(string: baseUrl)?.appendingPathComponent(path),
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        else {
            throw NSError(domain: "", code: 0, userInfo: ["Error": "Can't build url"])
        }

        urlComponents.queryItems = query?.map { URLQueryItem(name: $0.key, value: $0.value) }

        var urlRequest = URLRequest(url: try urlComponents.asURL())
        headers?.forEach { urlRequest.addValue($1, forHTTPHeaderField: $0) }

        if let body = body {
            urlRequest.httpBody = try JSONEncoder().encode(body)
        }

        return urlRequest
    }
}
