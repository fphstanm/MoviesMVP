//
//  File.swift
//  
//
//  Created by Philip on 27.10.2023.
//

import Foundation

struct GenreAPI {

    private let baseUrl: String

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    func makeMovieGenresRequest() -> AppRequest {
        AppRequest(baseUrl: baseUrl)
            .add(method: .get)
            .add(path: "genre/movie/list")
    }
}
