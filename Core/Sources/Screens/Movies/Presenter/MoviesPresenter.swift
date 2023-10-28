//
//  File.swift
//  
//
//  Created by Philip on 27.10.2023.
//

import BusinessLogic
import Combine
import Models

@MainActor
final class MoviesPresenter {

    @Published
    private(set) var state: State
    private let movieFacade: MovieFacading

    public init(movieFacade: MovieFacading) {
        self.movieFacade = movieFacade
        self.state = State.initial
    }

    // MARK: - Public methods

    func didScrollToBottom() {

    }

    func viewDidLoad() async {
        do {
            let moviesPage = try await movieFacade.getPopularMovies(page: 1)
            state.movies = moviesPage.items
        } catch {
            print(error)
        }
    }
}
