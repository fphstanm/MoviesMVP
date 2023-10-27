//
//  MoviesRouter.swift
//  
//
//  Created by Philip on 27.10.2023.
//

import Movies
import UIKit

class MoviesRouter: Routing {

    private let navigationController: UINavigationController

    public required init(navigationController: UINavigationController) {
        print("init MoviesRouter")
        self.navigationController = navigationController
    }

    deinit {
        print("deinit MoviesRouter")
    }

    public func start() {
        let viewController = MoviesViewController()
        navigationController.setViewControllers([viewController], animated: false)
    }
}
