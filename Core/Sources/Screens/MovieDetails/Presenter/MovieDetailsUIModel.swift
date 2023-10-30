//
//  File.swift
//  
//
//  Created by Philip on 30.10.2023.
//

import Foundation

extension MovieDetailsPresenter {
    static func makeUIModel(from state: State) -> MovieDetailsView.Model {
        let movieDetails = state.movieDetails
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let releaseDate = dateFormatter.string(from: movieDetails.releaseDate)

        return MovieDetailsView.Model(
            imageUrl: movieDetails.posterImageUrl,
            title: movieDetails.title,
            coutntryAndYear: releaseDate + ", " + movieDetails.productionCountries.map(\.name).joined(separator: " "),
            genres: movieDetails.genres.map { "#" + $0.name }.joined(separator: " "),
            rating: String(format: "%.1f", movieDetails.voteAverage),
            overview: movieDetails.overview
        )
    }
}
