//
//  File.swift
//  
//
//  Created by Philip on 27.10.2023.
//

import BusinessLogic
import Dip
import Networking

@MainActor
public enum DependencyContainer {

    private static let container = Dip.DependencyContainer { container in

        // MARK: - Facades

        container.register(.singleton, type: MovieFacading.self, factory: MovieFacade.init)

        // MARK: - Clients

        container.register(.singleton, type: GenreClienting.self, factory: GenreClient.init)
        container.register(.singleton, type: MovieClienting.self, factory: MovieClient.init)

        // MARK: - Adapters

        container.register(.singleton, type: NetworkClienting.self, factory: AlamofireClient.init)

    }

    // MARK: - Public methods

    public static func resolve<T>(tag: DependencyTagConvertible? = nil) -> T {
        try! container.resolve(tag: tag)
    }
}
