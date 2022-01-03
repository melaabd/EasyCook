//
//  Extensions&Utilles.swift
//  EasyCookTests
//
//  Created by melaabd on 1/3/22.
//

import XCTest
@testable import EasyCook

class Extensions_Utils: XCTestCase {
    
    func testContainAnyWord() {
        let string = " "
        XCTAssertFalse(string.containAnyWord())
    }
    
    func testCapitalizingFirstLetter() {
        let string = "name"
        XCTAssertEqual(string.capitalizingFirstLetter(), "Name")
    }

}
