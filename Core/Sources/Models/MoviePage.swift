//
//  File.swift
//  
//
//  Created by Philip on 27.10.2023.
//

import Foundation

public struct MoviePage: Equatable {

    public var items: [Movie]
    public let page: Int
    public let totalItems: Int
    public let totalPages: Int

    public init(items: [Movie], page: Int, totalItems: Int, totalPages: Int) {
        self.items = items
        self.page = page
        self.totalItems = totalItems
        self.totalPages = totalPages
    }

    // MARK: - Public methods

    public mutating func fillGenresNames(genres: [Genre]) {
        items.update { movie in
            movie.genres.update { genre in
                genre.name = genres.first(where: { $0.id == genre.id })?.name ?? ""
            }
        }
    }
}
