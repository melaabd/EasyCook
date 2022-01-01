//
//  Utils.swift
//  EasyCook
//
//  Created by melaabd on 12/26/21.
//

import UIKit

enum Theme: String {
    case prime
    case floor
    case backG
    case base
    var color:UIColor {
        return UIColor(named: rawValue) ?? .systemBlue
    }
}

typealias CompletionVoid = (()->Void)

func onMain(after: Double = 0, execute:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + after, execute: execute)
}

func onGlobal(after: Double = 0, execute:@escaping ()->()) {
    DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + after, execute: execute)
}
