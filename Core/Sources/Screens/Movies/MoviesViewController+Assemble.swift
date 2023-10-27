//
//  File.swift
//  
//
//  Created by Philip on 27.10.2023.
//

import Helpers

public extension MoviesViewController {
    static func assemble(router: MoviesRouting) -> MoviesViewController {
        let presenter = MoviesPresenter(movieFacade: DependencyContainer.resolve())
        let viewController = MoviesViewController(presenter: presenter, router: router)
        return viewController
    }
}
