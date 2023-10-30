//
//  File.swift
//  
//
//  Created by Philip on 27.10.2023.
//

import Combine
import UIKit

public protocol MoviesRouting {
    func onTapDetails(movieId: Int)
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
        navigationItem.rightBarButtonItem = makeSortBarButtonItem()
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

        state
            .map { $0.searchText.isEmpty }
            .sink { [weak self] isSearchTextEmpty in
                self?.navigationItem.rightBarButtonItem = isSearchTextEmpty ? self?.makeSortBarButtonItem() : nil
            }
            .store(in: &cancellables)

        state
            .compactMap(\.alert)
            .sink { [weak self] alert in
                self?.showAlert(alert: alert)
            }
            .store(in: &cancellables)

        state
            .compactMap(\.route)
            .sink { [router] route in
                switch route {
                case .movieDetails(let movieId):
                    router.onTapDetails(movieId: movieId)
                }
            }
            .store(in: &cancellables)

        contentView.onChangeSearchText = { [presenter] text in
            Task { await presenter.didChangeSearchText(text) }
        }

        contentView.onPullRefreshControl = { [presenter] in
            Task { await presenter.didPullToRefresh() }
        }

        contentView.onTapMovie = { [presenter] index in
            presenter.didTapMovie(withIndex: index)
        }

        contentView.onScrollToBottom = { [presenter] in
            Task { await presenter.didScrollToBottom() }
        }
    }

    // MARK: - Private methods

    private func makeSortBarButtonItem() -> UIBarButtonItem {
        UIBarButtonItem(
            title: "Sort",
            style: .plain,
            target: self,
            action: #selector(onTapRightBarButtonItem)
        )
    }

    // MARK: - Alerts

    private func showAlert(alert: MoviesPresenter.Alert) {
        switch alert {
        case .sortingActionSheet:
            showSortingActionSheet()
        }
    }

    private func showSortingActionSheet() {
        let alertController = UIAlertController(title: "Sort by:", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(
            UIAlertAction(title: "Popularity", style: .default) { [presenter] _ in
                Task { await presenter.didTapSort(by: .popularity) }
            }
        )
        alertController.addAction(
            UIAlertAction(title: "Rating", style: .default) { [presenter] _ in
                Task { await presenter.didTapSort(by: .rating) }
            }
        )
        alertController.addAction(
            UIAlertAction(title: "Release date", style: .default) { [presenter] _ in
                Task { await presenter.didTapSort(by: .releaseDate) }
            }
        )
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(alertController, animated: true)
    }

    // MARK: - Selectors

    @objc
    private func onTapRightBarButtonItem() {
        presenter.didTapSortButton()
    }
}
