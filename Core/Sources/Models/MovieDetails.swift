//
//  File.swift
//  
//
//  Created by Philip on 30.10.2023.
//

import Foundation

public struct MovieDetails: Equatable {

    public var genres: [Genre]
    public let id: Int
    public let overview: String
    public let posterImageUrl: URL?
    public let productionCountries: [MovieProductionCountry]
    public let releaseDate: Date
    public let title: String
    public let voteAverage: Float

    public init(
        genres: [Genre],
        id: Int,
        overview: String,
        posterImageUrl: URL?,
        productionCountries: [MovieProductionCountry],
        releaseDate: Date,
        title: String,
        voteAverage: Float
    ) {
        self.genres = genres
        self.id = id
        self.overview = overview
        self.posterImageUrl = posterImageUrl
        self.productionCountries = productionCountries
        self.releaseDate = releaseDate
        self.title = title
        self.voteAverage = voteAverage
    }

    public static let empty: MovieDetails = MovieDetails(
        genres: [],
        id: 0,
        overview: "",
        posterImageUrl: nil,
        productionCountries: [],
        releaseDate: Date(),
        title: "",
        voteAverage: 0
    )
}
