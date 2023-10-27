//
//  File.swift
//  
//
//  Created by Philip on 27.10.2023.
//

import Foundation
import Library

public struct Movie: Equatable {

    public var genres: [Genre]
    public let id: Int
    public let posterImageUrl: URL?
    public let releaseDate: Date
    public let title: String
    public let voteAverage: Float

    public init(genres: [Genre], id: Int, posterImageUrl: URL?, releaseDate: Date, title: String, voteAverage: Float) {
        self.genres = genres
        self.id = id
        self.posterImageUrl = posterImageUrl
        self.releaseDate = releaseDate
        self.title = title
        self.voteAverage = voteAverage
    }
}
