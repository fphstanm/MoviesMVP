//
//  File.swift
//  
//
//  Created by Philip on 27.10.2023.
//

import Models

public protocol GenreClienting {
    func movieGenres() async throws -> [Genre]
}

public final class GenreClient: GenreClienting {

    private let api: GenreAPI
    private let networkClient: NetworkClienting

    public init(networkClient: NetworkClienting) {
        self.api = GenreAPI(baseUrl: AppConstants.baseURL.absoluteString)
        self.networkClient = networkClient
    }

    // MARK: - Public methods

    public func movieGenres() async throws -> [Genre] {
        let request = try api.makeMovieGenresRequest().asUrlRequest()
        let response: GenreListResponse = try await networkClient.execute(request: request)
        return makeGenreList(response: response)
    }

    // MARK: - Private methods

    private func makeGenreList(response: GenreListResponse) -> [Genre] {
        response.genres.map { Genre(id: $0.id, name: $0.name) }
    }
}
