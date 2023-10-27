//
//  File.swift
//  
//
//  Created by Philip on 27.10.2023.
//

import Foundation

struct MovieAPI {

    private let baseUrl: String

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    func makePopularRequest(page: Int) -> AppRequest {
        AppRequest(baseUrl: baseUrl)
            .add(method: .get)
            .add(path: "movie/popular")
            .add(query: ["page": String(page)])
    }
}
