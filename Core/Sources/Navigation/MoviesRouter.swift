//
//  MoviesRouter.swift
//  
//
//  Created by Philip on 27.10.2023.
//

import Movies
import MovieDetails
import UIKit

class MoviesRouter: Routing {
    private let navigationController: UINavigationController

    public required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        let viewController = MoviesViewController.assemble(router: self)
        navigationController.setViewControllers([viewController], animated: false)
    }
}

// MARK: - MoviesRouting

extension MoviesRouter: MoviesRouting {
    func onTapDetails(movieId: Int) {
        let viewController = MovieDetailsViewController.assemble(router: self, movieId: movieId)
        navigationController.pushViewController(viewController, animated: true)
    }
}

// MARK: - MovieDetailsRouting

extension MoviesRouter: MovieDetailsRouting {

}
