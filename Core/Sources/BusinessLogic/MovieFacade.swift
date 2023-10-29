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

    private let genreClient: GenreClienting
    private let movieClient: MovieClienting
    private var genres: [Genre]

    // MARK: - Lifecycle

    public init(genreClient: GenreClienting, movieClient: MovieClienting) {
        self.genreClient = genreClient
        self.movieClient = movieClient
        self.genres = []
    }

    // MARK: - Public methods

    public func getPopularMovies(page: Int) async throws -> MoviesPage {
        async let moviesPage = movieClient.popular(page: page)
        async let genres = getGenres()
        var fetchedMoviesPage = try await moviesPage
        fetchedMoviesPage.fillGenresNames(genres: try await genres)
        return fetchedMoviesPage
    }

    // MARK: - Private methods

    private func getGenres() async throws -> [Genre] {
        if genres.isEmpty {
            return try await genreClient.movieGenres()
        } else {
            return genres
        }
    }
}
