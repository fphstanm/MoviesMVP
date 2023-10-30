//
//  File.swift
//  
//
//  Created by Philip on 30.10.2023.
//

import Combine
import UIKit

public protocol MovieDetailsRouting {

}

public final class MovieDetailsViewController: UIViewController {

    private let contentView = MovieDetailsView()
    private let presenter: MovieDetailsPresenter
    private let router: MovieDetailsRouting
    private var cancellables = [AnyCancellable]()

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
        setupBinding()
        Task { await presenter.viewDidLoad() }
    }

    // MARK: - Private methods

    private func setupBinding() {
        let state = presenter.$state.removeDuplicates()

        state
            .map { MovieDetailsPresenter.makeUIModel(from: $0) }
            .sink { [contentView] in
                contentView.render($0)
            }
            .store(in: &cancellables)
    }
}
