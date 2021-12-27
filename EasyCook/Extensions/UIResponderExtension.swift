//
//  UIResponderExtension.swift
//  EasyCook
//
//  Created by melaabd on 12/26/21.
//

import UIKit

extension UIResponder {
    static var identifier:String {
        return String(describing: self)
    }
}
