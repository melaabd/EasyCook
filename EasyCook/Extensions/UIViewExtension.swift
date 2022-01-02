//
//  ViewExtension.swift
//  EasyCook
//
//  Created by melaabd on 1/2/22.
//

import UIKit
extension UIView {

    /// return views that anabled to have skeleton
    @objc var subviewsSkeletonables: [UIView] {
        return subviewsToSkeleton.filter { $0.isSkeletonable }
    }

    
    /// return subviews of view
    @objc var subviewsToSkeleton: [UIView] {
        return subviews
    }
}

extension UITableViewCell {

    
    /// return subviews of contentView of cell
    override var subviewsToSkeleton: [UIView] {
        return contentView.subviews
    }
}
