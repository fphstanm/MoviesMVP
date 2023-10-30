//
//  File.swift
//  
//
//  Created by Philip on 28.10.2023.
//

import UIKit

extension MoviesPresenter {
    static func makeUIModel(from state: State) -> MoviesView.Model {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return MoviesView.Model(
            items: state.movies.map { movie in
                MoviesCell.Model(
                    id: movie.id,
                    imageUrl: movie.posterImageUrl,
                    title: movie.title,
                    rating: String(format: "%.1f", movie.voteAverage),
                    releaseDate: dateFormatter.string(from: movie.releaseDate),
                    genres: movie.genres.map { "#" + $0.name }.joined(separator: " ")
                )
            },
            isRefreshing: state.isLoading
        )
    }
}
