//
//  File.swift
//  
//
//  Created by Philip on 29.10.2023.
//

import Library
import UIKit

final class MoviesNavigationView: UIView {

    struct Model: Equatable {
        let isLoading: Bool
    }

    private let titleLabel = UILabel()
    private let activityIndidcatorView = UIActivityIndicatorView()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    func render(_ model: Model) {
        activityIndidcatorView.isHidden = !model.isLoading
        if model.isLoading {
            activityIndidcatorView.startAnimating()
        } else {
            activityIndidcatorView.stopAnimating()
        }
    }

    // MARK: - Setup

    private func setup() {
        setupTitleLabel()
        setupActivityIndidcatorView()
    }

    private func setupTitleLabel() {
        titleLabel.text = "Popular"
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        addSubview(titleLabel, constraints: [
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func setupActivityIndidcatorView() {
        addSubview(activityIndidcatorView, constraints: [
            activityIndidcatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndidcatorView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 2)
        ])
    }
}
