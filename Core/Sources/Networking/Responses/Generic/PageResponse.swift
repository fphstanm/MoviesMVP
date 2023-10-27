//
//  File.swift
//  
//
//  Created by Philip on 27.10.2023.
//

import Foundation

struct PaginatedResponse<Model: Decodable>: Decodable {
    let page: Int
    let results: [Model]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
