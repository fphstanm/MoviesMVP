//
//  File.swift
//  
//
//  Created by Philip on 30.10.2023.
//

import Library
import UIKit

final class MovieDetailsView: UIView {

    struct Model: Equatable {
        let imageUrl: URL?
        let title: String
        let coutntryAndYear: String
        let genres: String
        let rating: String
        let overview: String
    }

    private let backgroundImageView = UIImageView()
    private let backgroundImageBlurView = UIVisualEffectView()
    private let containerView = UIView()
    private let posterAndShortInfoView = UIView()
    private let posterImageView = UIImageView()
    private let shortInfoStackView = UIStackView()
    private let titleLabel = UILabel()
    private let countryYearLabel = UILabel()
    private let genresLabel = UILabel()
    private let ratingLabel = UILabel()
    private let overviewStackView = UIStackView()
    private let overviewTitleLabel = UILabel()
    private let overviewDescriptionLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    func render(_ model: Model) {
        backgroundImageView.setImage(url: model.imageUrl)
        posterImageView.setImage(url: model.imageUrl)
        titleLabel.text = model.title
        countryYearLabel.text = model.coutntryAndYear
        genresLabel.text = model.genres
        ratingLabel.text = model.rating
        overviewDescriptionLabel.text = model.overview
    }

    // MARK: - Setup

    private func setup() {
        setupBackgroundImageView()
        setupBackgroundImageBlurView()
        setupContainerView()
        setupPosterAndShortInfoView()
        setupPosterImageView()
        setupShortInfoStackView()
        setupTitleLabel()
        setupCountryAndYearLabel()
        setupGenresLabel()
        setupRatingLabel()
        setupOverviewStackView()
        setupOverviewTitleLabel()
        setupOverviewDescriptionLabel()
    }

    private func setupBackgroundImageView() {
        addSubview(backgroundImageView, constraints: [
            backgroundImageView.heightAnchor.constraint(equalToConstant: 300),
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func setupBackgroundImageBlurView() {
        let blurEffect = UIBlurEffect(style: .light)
        backgroundImageBlurView.effect = blurEffect
        backgroundImageBlurView.frame = backgroundImageView.bounds
        backgroundImageBlurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundImageView.addSubview(backgroundImageBlurView)
    }

    private func setupContainerView() {
        containerView.layer.cornerRadius = 28
        containerView.backgroundColor = .white
        containerView.clipsToBounds = false
        addSubview(containerView, constraints: [
            containerView.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: -28),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func setupPosterAndShortInfoView() {
        containerView.addSubview(posterAndShortInfoView, constraints: [
            posterAndShortInfoView.heightAnchor.constraint(equalToConstant: 160),
            posterAndShortInfoView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            posterAndShortInfoView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            posterAndShortInfoView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
    }

    private func setupPosterImageView() {
        posterImageView.layer.cornerRadius = 12
        posterImageView.clipsToBounds = true
        posterAndShortInfoView.addSubview(posterImageView, constraints: [
            posterImageView.heightAnchor.constraint(equalToConstant: 200),
            posterImageView.widthAnchor.constraint(equalToConstant: 120),
            posterImageView.topAnchor.constraint(equalTo: posterAndShortInfoView.topAnchor, constant: -50),
            posterImageView.leadingAnchor.constraint(equalTo: posterAndShortInfoView.leadingAnchor),
        ])
    }

    private func setupShortInfoStackView() {
        [titleLabel, countryYearLabel, genresLabel, UIView(), ratingLabel].forEach(shortInfoStackView.addArrangedSubview)
        shortInfoStackView.axis = .vertical
        shortInfoStackView.spacing = 6
        posterAndShortInfoView.addSubview(shortInfoStackView, constraints: [
            shortInfoStackView.topAnchor.constraint(equalTo: posterAndShortInfoView.topAnchor, constant: 16),
            shortInfoStackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
            shortInfoStackView.trailingAnchor.constraint(equalTo: posterAndShortInfoView.trailingAnchor),
            shortInfoStackView.bottomAnchor.constraint(equalTo: posterAndShortInfoView.bottomAnchor, constant: -16)
        ])
    }

    private func setupTitleLabel() {
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.numberOfLines = 2
    }

    private func setupCountryAndYearLabel() {
        countryYearLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        countryYearLabel.textColor = .gray
        countryYearLabel.numberOfLines = 2
    }

    private func setupGenresLabel() {
        genresLabel.font = .systemFont(ofSize: 14, weight: .regular)
        genresLabel.textColor = .lightGray
        genresLabel.numberOfLines = 2
    }

    private func setupRatingLabel() {
        ratingLabel.textColor = .orange
        ratingLabel.font = .systemFont(ofSize: 20, weight: .bold)
    }

    private func setupOverviewStackView() {
        [overviewTitleLabel, overviewDescriptionLabel, UIView()].forEach(overviewStackView.addArrangedSubview)
        overviewStackView.axis = .vertical
        overviewStackView.spacing = 12
        containerView.addSubview(overviewStackView, constraints: [
            overviewStackView.topAnchor.constraint(equalTo: posterAndShortInfoView.bottomAnchor, constant: 20),
            overviewStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            overviewStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            overviewStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
    }

    private func setupOverviewTitleLabel() {
        overviewTitleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        overviewTitleLabel.text = "Overview"
    }

    private func setupOverviewDescriptionLabel() {
        overviewDescriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        overviewDescriptionLabel.numberOfLines = 0
    }
}
