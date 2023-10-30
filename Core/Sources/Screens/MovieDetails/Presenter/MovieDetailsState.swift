//
//  File.swift
//  
//
//  Created by Philip on 30.10.2023.
//

import Foundation
import Models

extension MovieDetailsPresenter {

    struct State: Equatable {
        let movieId: Int
        var movieDetails: MovieDetails
    }
}
