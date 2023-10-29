//
//  File.swift
//  
//
//  Created by Philip on 27.10.2023.
//

import Combine
import UIKit

public protocol MoviesRouting {
    func onTapDetails()
}

public class MoviesViewController: UIViewController {

    private let titleView = MoviesNavigationView()
    private let contentView = MoviesView()
    private let presenter: MoviesPresenter
    private let router: MoviesRouting
    private var cancellables = [AnyCancellable]()

    // MARK: - Lifecycle

    init(presenter: MoviesPresenter, router: MoviesRouting) {
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

    // MARK: - Public methods

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationView()
        setupBinding()
        Task { await presenter.viewDidLoad() }
    }

    // MARK: - Private methods

    private func setupNavigationView() {
        navigationItem.titleView = titleView
    }

    private func setupBinding() {
        let state = presenter.$state.removeDuplicates()

        state
            .map { MoviesPresenter.makeUIModel(from: $0) }
            .sink { [contentView] in
                contentView.render($0)
            }
            .store(in: &cancellables)

        state
            .map { MoviesNavigationView.Model(isLoading: $0.isLoading) }
            .sink { [titleView] in
                titleView.render($0)
            }
            .store(in: &cancellables)

        contentView.onScrollToBottom = { [presenter] in
            Task { await presenter.didScrollToBottom() }
        }

        contentView.onChangeSearchText = { [presenter] text in
            Task { await presenter.didChangeSearchText(text) }
        }
    }
}
