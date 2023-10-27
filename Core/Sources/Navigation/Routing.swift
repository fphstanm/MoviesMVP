//
//  File.swift
//  
//
//  Created by Philip on 27.10.2023.
//

import UIKit

@MainActor
protocol Routing {
    init(navigationController: UINavigationController)

    func start()
}
