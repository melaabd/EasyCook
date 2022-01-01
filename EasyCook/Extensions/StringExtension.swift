//
//  ExtensionString.swift
//  EasyCook
//
//  Created by melaabd on 12/30/21.
//

import Foundation


extension String {
    func containAnyWord() -> Bool {
        return replacingOccurrences(of: " ", with: "").count != 0
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
