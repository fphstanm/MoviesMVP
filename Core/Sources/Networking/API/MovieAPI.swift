//
//  File.swift
//  
//
//  Created by Philip on 27.10.2023.
//

import Foundation

struct MovieAPI {

    private let baseUrl: URL

    init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }

    func makePopularMoviesRequest(page: Int) -> AppRequest {
        AppRequest(baseUrl: baseUrl)
            .add(method: .get)
            .add(path: "movie/popular")
            .add(query: ["page": String(page)])
    }

    func makeMovieGenresRequest() -> AppRequest {
        AppRequest(baseUrl: baseUrl)
            .add(method: .get)
            .add(path: "genre/movie/list")
    }
}
