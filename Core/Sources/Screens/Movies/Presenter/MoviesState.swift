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
        var totalPages: Int
        var isLoading: Bool

        static let initial: State = State(movies: [], page: 1, totalPages: 1, isLoading: false)
    }
}
