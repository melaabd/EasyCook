//
//  CollectionViewExtension.swift
//  EasyCook
//
//  Created by melaabd on 1/2/22.
//

import UIKit
extension UICollectionView {
    
    /// add placeholder view to show that collection view doesn't have items
    /// - Parameter title: no items message `String`
    func setEmptyView(_ title: String? = "No Items Found") {
        let emptyView = UIView(frame: CGRect(x: center.x, y: center.y, width: bounds.size.width, height: bounds.size.height))
        emptyView.backgroundColor = .clear
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .darkGray
        titleLabel.font = .boldSystemFont(ofSize: 24)
        emptyView.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true

        titleLabel.text = title
        backgroundView = emptyView
    }
}
