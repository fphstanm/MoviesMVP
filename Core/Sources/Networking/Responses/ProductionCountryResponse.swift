//
//  File.swift
//  
//
//  Created by Philip on 30.10.2023.
//

struct ProductionCountryResponse: Decodable {

    let code: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case code = "iso_3166_1"
        case name
    }
}
