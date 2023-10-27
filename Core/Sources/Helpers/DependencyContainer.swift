//
//  File.swift
//  
//
//  Created by Philip on 27.10.2023.
//

import Dip

@MainActor
public enum DependencyContainer {

    private static let container = Dip.DependencyContainer { container in

    }

    public static func resolve<T>(tag: DependencyTagConvertible? = nil) -> T {
        try! container.resolve(tag: tag)
    }
}
