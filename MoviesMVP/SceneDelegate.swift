//
//  SceneDelegate.swift
//  MoviesMVP
//
//  Created by Philip on 27.10.2023.
//

import Navigation
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    private var router: AppRouter?
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()

        guard let window = window else { return }
        router = AppRouter(window: window)
        router?.start()
    }
}
