//
//  File.swift
//  
//
//  Created by Philip on 28.10.2023.
//

import Helpers
import Library
import UIKit

final class MoviesCell: UICollectionViewCell {

    struct Model: Equatable, Hashable {
        let imageUrl: URL
        let title: String
        let rating: String
        let genres: String
    }

    private let shadowView = UIView()
    private let containerView = UIView()
    private let imageView = UIImageView()
    private let infoStackView = UIStackView()
    private let titleRatingStackView = UIStackView()
    private let titleLabel = UILabel()
    private let ratingLabel = UILabel()
    private let genresLabel = UILabel()

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
        shadowView.dropShadow(color: .lightGray, opacity: 0.5, offset: .zero, radius: 10)
    }

    // MARK: - Private methods

    func render(_ model: Model) {
        imageView.setImage(url: model.imageUrl)
        titleLabel.text = model.title
        ratingLabel.text = model.rating
        genresLabel.text = model.genres
    }

    // MARK: - Setup
    
    private func setup() {
        setupShadowView()
        setupContainerView()
        setupImageView()
        setupInfoStackView()
        setupTitleRatingStackView()
        setupTitleLabel()
        setupRatingLabel()
        setupGenresLabel()
    }

    private func setupShadowView() {
        shadowView.layer.cornerRadius = 12
        shadowView.backgroundColor = .white
        contentView.addSubview(shadowView, constraints: [
            shadowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.hOffset),
            shadowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            shadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.hOffset)
        ])
    }

    private func setupContainerView() {
        containerView.clipsToBounds = false
        containerView.backgroundColor = .clear
        containerView.layer.cornerRadius = 12
        shadowView.addSubview(containerView, constraints: [
            containerView.topAnchor.constraint(equalTo: shadowView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor)
        ])
    }


    private func setupShadow() {
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowRadius = 8
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
        containerView.layer.shouldRasterize = true
        containerView.layer.rasterizationScale = UIScreen.main.scale
    }

    
    private func setupImageView() {
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        containerView.addSubview(imageView, constraints: [
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: -Constants.vOffset),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.hOffset),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Constants.vOffset)
        ])
    }

    private func setupInfoStackView() {
        [titleRatingStackView, UIView(), genresLabel].forEach(infoStackView.addArrangedSubview)
        infoStackView.axis = .vertical
        infoStackView.spacing = 2
        addSubview(infoStackView, constraints: [
            infoStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.vOffset),
            infoStackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            infoStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Constants.vOffset),
            infoStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.hOffset)
        ])
    }

    private func setupTitleRatingStackView() {
        [titleLabel, UIView() , ratingLabel].forEach(titleRatingStackView.addArrangedSubview)
        titleRatingStackView.alignment = .top
        titleRatingStackView.spacing = 2
    }

    private func setupTitleLabel() {
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        titleLabel.numberOfLines = 3
    }

    private func setupRatingLabel() {
        ratingLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        ratingLabel.font = .systemFont(ofSize: 20, weight: .bold)
        ratingLabel.textColor = .orange
    }

    private func setupGenresLabel() {
        genresLabel.font = .systemFont(ofSize: 14, weight: .regular)
        genresLabel.textColor = .gray
        genresLabel.numberOfLines = 2
    }
}

// MARK: - Constants

extension MoviesCell {
    enum Constants {
        static let hOffset: CGFloat = 12
        static let vOffset: CGFloat = 16
    }
}
