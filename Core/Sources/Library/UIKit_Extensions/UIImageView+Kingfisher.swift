//
//  File.swift
//  
//
//  Created by Philip on 28.10.2023.
//

import Kingfisher
import UIKit

public extension UIImageView {
    func setImage(url: URL?, placeholder: UIImage? = nil) {
        kf.setImage(with: url, placeholder: placeholder)
    }
}
