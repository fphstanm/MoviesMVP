//
//  File.swift
//  
//
//  Created by Philip on 28.10.2023.
//

import Library
import UIKit

final class MoviesView: UIView {

    struct Model: Equatable {
        let items: [MoviesCell.Model]
    }

    typealias DataSource = UICollectionViewDiffableDataSource<Int, MoviesCell.Model>

    private let stackView = UIStackView()
    private let searchBar = UISearchBar()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private lazy var dataSource = makeDataSource()
    // callbacks
    var onChangeSearchText: (String) -> Void = { _ in }
    var onScrollToBottom: () -> Void = { }

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard !(collectionView.collectionViewLayout is UICollectionViewFlowLayout) else {
            return
        }
        setupCollectionViewLayout()
    }

    // MARK: - Public methods

    func render(_ modell: Model) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, MoviesCell.Model>()
        snapshot.appendSections([0])
        snapshot.appendItems(modell.items, toSection: 0)
        dataSource.apply(snapshot)
    }

    // MARK: - Setup

    private func setup() {
        backgroundColor = .white
        setupStackView()
        setupSearchBar()
        setupCollectionView()
    }

    private func setupStackView() {
        [searchBar, collectionView].forEach(stackView.addArrangedSubview)
        stackView.axis = .vertical
        addSubview(stackView, constraints: [
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func setupSearchBar() {
        searchBar.delegate = self
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.keyboardDismissMode = .onDrag
        collectionView.register(MoviesCell.self, forCellWithReuseIdentifier: String(describing: MoviesCell.self))
    }

    private func setupCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: frame.width, height: 200)
        collectionView.collectionViewLayout = layout
    }

    private func makeDataSource() -> DataSource {
        return DataSource(collectionView: collectionView) { collectionView, indexPath, model in
            let cell: MoviesCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.render(model)
            return cell
        }
    }
}

// MARK: - UISearchBarDelegate

extension MoviesView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        onChangeSearchText(searchText)
    }
}

// MARK: - UICollectionViewDelegate

extension MoviesView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView.numberOfItems(inSection: 0) - 5 == indexPath.item {
            onScrollToBottom()
        }
    }
}
