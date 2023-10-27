//
//  File.swift
//  
//
//  Created by Philip on 27.10.2023.
//

import UIKit

public protocol MoviesRouting {
    func onTapDetails()
}

public class MoviesViewController: UIViewController {

    private let presenter: MoviesPresenter
    private let router: MoviesRouting

    // MARK: - Lifecycle

    init(presenter: MoviesPresenter, router: MoviesRouting) {
        self.presenter = presenter
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        view.backgroundColor = .orange
    }
}
