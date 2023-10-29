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

    func didChangeSearchText(_ text: String) async {
        state.searchText = text
        await loadFirstPage()
    }

    func didScrollToBottom() async {
        guard state.page != state.totalPages, !state.isLoading else {
            return
        }

        await loadNextPage()
    }

    func didTapSortButton() {
        state.alert = .sortingActionSheet
        state.alert = nil
    }

    func didTapSort(by option: MoviesSortOrder) async {
        let previousOrder = state.sortOrder
        state.sortOrder = option
        if previousOrder != option {
            await loadFirstPage()
        }
    }

    func viewDidLoad() async {
        await loadFirstPage()
    }

    // MARK: - Private method

    private func loadFirstPage() async {
        do {
            state.isLoading = true
            let page = 1
            let moviesPage: MoviesPage = try await {
                if state.searchText.isEmpty {
                    return try await movieFacade.getMovies(page: page, sortOrder: state.sortOrder)
                } else {
                    return try await movieFacade.searchMovies(page: page, query: state.searchText)
                }
            }()
            state.isLoading = false
            state.movies = moviesPage.items
            state.page = 1
            state.totalPages = moviesPage.totalPages
        } catch {
            state.isLoading = false
            print(error)
        }
    }

    private func loadNextPage() async {
        do {
            state.isLoading = true
            let nextPage = state.page + 1
            let moviesPage: MoviesPage = try await {
                if state.searchText.isEmpty {
                    return try await movieFacade.getMovies(page: nextPage, sortOrder: state.sortOrder)
                } else {
                    return try await movieFacade.searchMovies(page: nextPage, query: state.searchText)
                }
            }()
            state.isLoading = false
            state.movies.append(contentsOf: moviesPage.items)
            state.page = nextPage
            state.totalPages = moviesPage.totalPages
        } catch {
            state.isLoading = false
            print(error)
        }
    }
}
