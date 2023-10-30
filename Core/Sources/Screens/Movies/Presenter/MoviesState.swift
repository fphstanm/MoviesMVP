//
//  File.swift
//  
//
//  Created by Philip on 28.10.2023.
//

import Models

extension MoviesPresenter {

    struct State: Equatable {
        var movies: [Movie]
        var page: Int
        var searchText: String
        var sortOrder: MoviesSortOrder
        var totalPages: Int
        var isLoading: Bool
        var alert: Alert?
        var route: Route?

        static let initial: State = State(
            movies: [],
            page: 1,
            searchText: "",
            sortOrder: .popularity,
            totalPages: 1,
            isLoading: false
        )
    }

    enum Alert {
        case sortingActionSheet
    }

    enum Route: Equatable {
        case movieDetails(movieId: Int)
    }
}
