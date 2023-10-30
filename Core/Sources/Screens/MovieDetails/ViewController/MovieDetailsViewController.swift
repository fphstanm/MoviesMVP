//
//  File.swift
//  
//
//  Created by Philip on 30.10.2023.
//

import UIKit

public protocol MovieDetailsRouting {

}

public final class MovieDetailsViewController: UIViewController {

    private let contentView = MovieDetailsView()
    private let presenter: MovieDetailsPresenter
    private let router: MovieDetailsRouting

    // MARK: - Lifecycle

    init(presenter: MovieDetailsPresenter, router: MovieDetailsRouting) {
        self.presenter = presenter
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func loadView() {
        view = contentView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        Task { await presenter.viewDidLoad() }
    }
}
