//
//  UIViewControllerExtension.swift
//  EasyCook
//
//  Created by melaabd on 12/31/21.
//

import UIKit

protocol Navigatable { }

extension UIViewController: Navigatable {}

extension Navigatable where Self: UIViewController {
    static func getViewController(storyboard:UIStoryboard.Storyboard = .main, identifier:String? = Self.identifier) -> Self {
        let identifierBind = (identifier != nil ? identifier : Self.identifier) ?? Self.identifier
        guard let viewController = UIStoryboard(storyboard: storyboard).instantiateViewController(withIdentifier: identifierBind) as? Self else {
            fatalError("Couldn't instantiate view controller with identifier \(Self.identifier) ")
        }
        return viewController
    }
    
}
