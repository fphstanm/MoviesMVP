//
//  File.swift
//  
//
//  Created by Philip on 30.10.2023.
//

import Helpers

public extension MovieDetailsViewController {
    static func assemble(router: MovieDetailsRouting, movieId: Int) -> MovieDetailsViewController {
        let presenter = MovieDetailsPresenter(movieFacade: DependencyContainer.resolve(), movieId: movieId)
        let viewController = MovieDetailsViewController(presenter: presenter, router: router)
        return viewController
    }
}
