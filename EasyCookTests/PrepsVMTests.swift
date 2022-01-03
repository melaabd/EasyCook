//
//  PrepsVM.swift
//  EasyCookTests
//
//  Created by melaabd on 1/3/22.
//

import XCTest
@testable import EasyCook

class PrepsVMTests: XCTestCase {

    var prepsVM: PrepsVM!
    
    override func setUp() {
        super.setUp()
        
        prepsVM = PrepsVM()
    }
    
    override func tearDown() {
        prepsVM = nil
        super.tearDown()
    }

    func testInitialization() {
        XCTAssertNotNil(prepsVM, "The view model should not be nil.")
    }

    func testIngredientMatchs() {
        // Convert Recipes.json to Data
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "Recipes", ofType: "json")
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped) else {
            fatalError("Data is nil")
        }
        // Provie any Codable struct
        let recipes = try! JSONDecoder().decode(Recipes.self, from: data)
        let ingredients = ["tomato", "onion"]
        prepsVM.recipeCellVMs = recipes.map{RecipeCellVM($0)}
        prepsVM.ingredientCellVMs = ingredients.enumerated().map { (index, value) in
            return IngredientCellVM(index: index, title: value)
        }
        prepsVM.getMatchedRecipes()
        XCTAssertNotNil(prepsVM.filteredRecipeCellVM)
        XCTAssertEqual(prepsVM.filteredRecipeCellVM?.count, 3)
    }
}
