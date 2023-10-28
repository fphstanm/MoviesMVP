//
//  File.swift
//  
//
//  Created by Philip on 28.10.2023.
//

import UIKit

extension MoviesPresenter {
    static func makeUIModel(from state: State) -> MoviesView.Model {
        return MoviesView.Model(
            items: state.movies.map { movie in
                MoviesCell.Model(
                    imageUrl: movie.posterImageUrl!,
                    title: movie.title,
                    rating: String(format: "%.1f", movie.voteAverage),
                    genres: movie.genres.map { "#" + $0.name }.joined(separator: " ")
                )
            }
        )
    }
}
