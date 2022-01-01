//
//  UIStoryboardExtension.swift
//  EasyCook
//
//  Created by melaabd on 12/31/21.
//

import UIKit


extension UIStoryboard {
    enum Storyboard: String {
        case main
        var name: String {
            return rawValue.capitalizingFirstLetter()
        }
    }
    
    // MARK: - Convenience Initializers
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.name, bundle: bundle)
    }
    
    
    // MARK: - Class Functions
    
    class func storyboard(_ storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.name, bundle: bundle)
    }
}
