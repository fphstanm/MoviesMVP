//
//  File.swift
//  
//
//  Created by Philip on 30.10.2023.
//

import UIKit

final class MovieDetailsView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setup() {
        backgroundColor = .orange
    }

}
