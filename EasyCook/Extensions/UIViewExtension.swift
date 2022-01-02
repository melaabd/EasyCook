//
//  ViewExtension.swift
//  EasyCook
//
//  Created by melaabd on 1/2/22.
//

import UIKit
//extension UIView {
//
//    /// return views that anabled to have skeleton
//    @objc var subviewsSkeletonables: [UIView] {
//        return subviewsToSkeleton.filter { $0.isSkeletonable }
//    }
//
//    @objc var subviewsToSkeleton: [UIView] {
//        return subviews
//    }
//}

extension UITableViewCell {

    override var subviewsToSkeleton: [UIView] {
        return contentView.subviews
    }
}
