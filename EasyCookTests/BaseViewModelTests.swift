//
//  BaseViewModel.swift
//  EasyCookTests
//
//  Created by melaabd on 1/3/22.
//

import XCTest
@testable import EasyCook

class BaseViewModelTests: XCTestCase {

    var baseViewModel: BaseViewModel!
    
    override func setUp() {
        super.setUp()
        
        baseViewModel = BaseViewModel()
    }
    
    override func tearDown() {
        baseViewModel = nil
        super.tearDown()
    }

    func testInitialization() {
        XCTAssertNotNil(baseViewModel, "The view model should not be nil.")
    }
    
    func testJSONDecoding() {
        
        // Convert Recipes.json to Data
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "Recipes", ofType: "json")
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped) else {
            fatalError("Data is nil")
        }
        
        // Provie any Codable struct
        let recipes = try! JSONDecoder().decode(Recipes.self, from: data)
        XCTAssertEqual(recipes.first?.id, 2380570)
    }

    func testBaseViewModel() {
        // Convert Recipes.json to Data
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "Recipes", ofType: "json")
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped) else {
            fatalError("Data is nil")
        }
        
        // Provie any Codable struct
        let recipes = try! JSONDecoder().decode(Recipes.self, from: data)
        baseViewModel.recipeCellVMs = recipes.map{RecipeCellVM($0)}
        
        XCTAssertEqual(baseViewModel.recipeCellVMs?.first?.id, 2380570)
        XCTAssertEqual(baseViewModel.recipeCellVMs?.first?.userName, "Liam Nichols")
    }
}
