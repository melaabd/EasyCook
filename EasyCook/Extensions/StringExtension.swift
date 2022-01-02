//
//  ExtensionString.swift
//  EasyCook
//
//  Created by melaabd on 12/30/21.
//

import Foundation


extension String {
    
    /// check if strign have any words
    /// - Returns: `Bool`
    func containAnyWord() -> Bool {
        return replacingOccurrences(of: " ", with: "").count != 0
    }
    
    /// capitaliz first letter of the text
    /// - Returns: capitalized `String`
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
