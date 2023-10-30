//
//  File.swift
//  
//
//  Created by Philip on 30.10.2023.
//

import Foundation

struct MovieDetailsResponse: Decodable {

    let genres: [GenreResponse]
    let id: Int
    let overview: String
    let posterPath: String?
    let productionCountries: [ProductionCountryResponse]
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Float

    enum CodingKeys: String, CodingKey {
        case genres
        case id
        case overview
        case posterPath = "poster_path"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
    }
}
