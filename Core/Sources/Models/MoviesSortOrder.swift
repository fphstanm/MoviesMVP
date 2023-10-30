//
//  File.swift
//  
//
//  Created by Philip on 29.10.2023.
//

public enum MoviesSortOrder {

    case releaseDate
    case popularity
    case rating

    public var id: String {
        switch self {
        case .releaseDate:
            return "primary_release_date.desc"
        case .popularity:
            return "popularity.desc"
        case .rating:
            return "vote_average.desc"
        }
    }
}
