//
//  BaseRecipeVMTests.swift
//  EasyCookTests
//
//  Created by melaabd on 1/3/22.
//

import XCTest
@testable import EasyCook

class VMBasedOnRecipeTests: XCTestCase {
    
    var recipe:Recipe!
    
    override func setUp() {
        super.setUp()
        
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "Recipes", ofType: "json")
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped) else {
            fatalError("Data is nil")
        }
        
        // Provie any Codable struct
        recipe = try! JSONDecoder().decode(Recipes.self, from: data).first
    }
    
    override func tearDown() {
        recipe = nil
        super.tearDown()
    }

    func testBaseRecipeVMInitialization() {
        let baseRecipeVM = BaseRecipeVM(recipe)
        XCTAssertNotNil(baseRecipeVM.imageURL)
        XCTAssertEqual(baseRecipeVM.userName,"Liam Nichols")
    }
    
    func testRecipeStepCellVMInitialization() {
        let recipeStepCellVM = RecipeStepCellVM(recipe.steps.first!)
        XCTAssertNotNil(recipeStepCellVM.imageURL)
        XCTAssertEqual(recipeStepCellVM.desc, "Crush the garlic cloves and add all ingredients apart from the ribs into a pan")
    }
    
    func testRecipeDetailsVMInitialization() {
        let recipeDetailsVM = RecipeDetailsVM(recipe)
        XCTAssertNotNil(recipeDetailsVM.stepsVMs)
        XCTAssertNotNil(recipeDetailsVM.ingredientCellVMs)
        XCTAssertEqual(recipeDetailsVM.stepsVMs?.count, 1)
    }
    
    func testRecipeVMInitialization() {
        let recipeCellVM = RecipeCellVM(recipe)
        XCTAssertNotNil(recipeCellVM.recipe)
    }
    
    func testIngredientCellVMInitialization() {
        let ingredientCellVM = IngredientCellVM(index: 1, title: "Ingredient1")
        XCTAssertEqual(ingredientCellVM.index, 1)
    }
    
}
