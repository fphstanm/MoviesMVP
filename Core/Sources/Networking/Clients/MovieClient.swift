//
//  File.swift
//  
//
//  Created by Philip on 27.10.2023.
//

import Foundation
import Models

public protocol MovieClienting {
    func getMovies(page: Int, sortOrder: MoviesSortOrder) async throws -> MoviesPage
    func searchMovies(page: Int, query: String) async throws -> MoviesPage
    func getMovieGenres() async throws -> [Genre]
}

public final class MovieClient: MovieClienting {

    private let api: MovieAPI
    private let networkClient: NetworkClienting

    public init(networkClient: NetworkClienting) {
        self.api = MovieAPI(baseUrl: AppConstants.baseURL)
        self.networkClient = networkClient
    }

    // MARK: - Public methods

    public func getMovies(page: Int, sortOrder: MoviesSortOrder) async throws -> MoviesPage {
        let request = try api.makeDiscoverMoviesRequest(page: page, sortBy: sortOrder.id).asUrlRequest()
        let respone: PaginatedResponse<MovieResponse> = try await networkClient.execute(request: request)
        return makeMoviesPage(response: respone)
    }

    public func searchMovies(page: Int, query: String) async throws -> MoviesPage {
        let request = try api.makeSearchMoviesRequest(page: page, query: query).asUrlRequest()
        let response: PaginatedResponse<MovieResponse> = try await networkClient.execute(request: request)
        return makeMoviesPage(response: response)
    }

    public func getMovieGenres() async throws -> [Genre] {
        let request = try api.makeMovieGenresRequest().asUrlRequest()
        let response: GenreListResponse = try await networkClient.execute(request: request)
        return makeGenreList(response: response)
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
            posterImageUrl: response.posterPath.flatMap(AppConstants.imageBaseURL.appendingPathComponent),
            releaseDate: dateFormatter.date(from: response.releaseDate) ?? Date(),
            title: response.title,
            voteAverage: response.voteAverage
        )
    }

    private func makeGenreList(response: GenreListResponse) -> [Genre] {
        response.genres.map { Genre(id: $0.id, name: $0.name) }
    }
}
