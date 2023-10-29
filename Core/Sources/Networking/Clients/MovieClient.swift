//
//  File.swift
//  
//
//  Created by Philip on 27.10.2023.
//

import Foundation
import Models

public protocol MovieClienting {
    func popular(page: Int) async throws -> MoviesPage
}

public final class MovieClient: MovieClienting {

    private let api: MovieAPI
    private let networkClient: NetworkClienting

    public init(networkClient: NetworkClienting) {
        self.api = MovieAPI(baseUrl: AppConstants.baseURL.absoluteString)
        self.networkClient = networkClient
    }

    // MARK: - Public methods

    public func popular(page: Int) async throws -> MoviesPage {
        let request = try api.makePopularRequest(page: page).asUrlRequest()
        let respone: PaginatedResponse<MovieResponse> = try await networkClient.execute(request: request)
        return makeMoviesPage(response: respone)
    }

    // MARK: - Private methods

    private func makeMoviesPage(response: PaginatedResponse<MovieResponse>) -> MoviesPage {
        return MoviesPage(
            items: response.results.map(makeMovie),
            page: response.page,
            totalItems: response.totalResults,
            totalPages: response.totalPages
        )
    }

    private func makeMovie(response: MovieResponse) -> Movie {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"

        return Movie(
            genres: response.genreIDS.map { Genre(id: $0, name: "") },
            id: response.id,
            posterImageUrl: AppConstants.imageBaseURL.appendingPathComponent(response.posterPath),
            releaseDate: dateFormatter.date(from: response.releaseDate) ?? Date(),
            title: response.title,
            voteAverage: response.voteAverage
        )
    }
}
