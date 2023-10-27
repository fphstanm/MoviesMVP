//
//  File.swift
//  
//
//  Created by Philip on 27.10.2023.
//

import UIKit

public class AppRouter {

    private let window: UIWindow
    private var childRouters: [Routing]

    public init(window: UIWindow) {
        self.window = window
        self.childRouters = []
        print("init AppRouter")
    }

    deinit {
        print("deinit AppRouter")
    }

    public func start() {
        startMoviesFlow()
    }

    private func startMoviesFlow() {
        let navigationController = UINavigationController()
        let moviesRouter = MoviesRouter(navigationController: navigationController)
        childRouters.append(moviesRouter)
        window.rootViewController = navigationController
        moviesRouter.start()
    }
}
