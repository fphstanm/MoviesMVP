//
//  File.swift
//  
//
//  Created by Philip on 27.10.2023.
//

import Models
import Networking

public protocol MovieFacading {
    func getPopularMovies(page: Int) async throws -> MoviesPage
}

public actor MovieFacade: MovieFacading {

    private let movieClient: MovieClienting
    private var genres: [Genre]

    // MARK: - Lifecycle

    public init(movieClient: MovieClienting) {
        self.movieClient = movieClient
        self.genres = []
    }

    // MARK: - Public methods

    public func getPopularMovies(page: Int) async throws -> MoviesPage {
        async let moviesPage = movieClient.getPopularMovies(page: page)
        async let genres = getGenres()
        var fetchedMoviesPage = try await moviesPage
        fetchedMoviesPage.fillGenresNames(genres: try await genres)
        return fetchedMoviesPage
    }

    // MARK: - Private methods

    private func getGenres() async throws -> [Genre] {
        if genres.isEmpty {
            return try await movieClient.getMovieGenres()
        } else {
            return genres
        }
    }
}
