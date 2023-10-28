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
        var isLoading: Bool

        static let initial: State = State(movies: [], isLoading: false)
    }
}
