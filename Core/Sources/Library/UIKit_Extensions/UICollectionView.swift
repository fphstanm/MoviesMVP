//
//  File.swift
//  
//
//  Created by Philip on 28.10.2023.
//

import UIKit

public extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Failed to dequeue cell of type \(String(describing: T.self))")
        }
        return cell
    }
}
