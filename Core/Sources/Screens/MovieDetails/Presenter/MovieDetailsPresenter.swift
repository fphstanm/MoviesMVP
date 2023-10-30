//
//  File.swift
//  
//
//  Created by Philip on 30.10.2023.
//

import BusinessLogic
import Combine
import Models

@MainActor
final class MovieDetailsPresenter {

    @Published
    private(set) var state: State
    private let movieFacade: MovieFacading

    public init(movieFacade: MovieFacading, movieId: Int) {
        self.movieFacade = movieFacade
        self.state = State(movieId: movieId, movieDetails: .empty)
    }

    // MARK: - Public methods

    func viewDidLoad() async {
        do {
            state.movieDetails = try await movieFacade.getMovieDetails(id: state.movieId)
        } catch {

        }
    }

    // MARK: - Private methods
}
