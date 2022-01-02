//
//  RecipeDetailsVM.swift
//  EasyCook
//
//  Created by melaabd on 12/31/21.
//

import Foundation


class RecipeDetailsVM: BaseRecipeVM {
    
    var stepsVMs:[RecipeStepCellVM]?
    var ingredientCellVMs:[IngredientCellVM]?
    var storyCellVM:RecipeStepCellVM?
    var sectionsTitles = ["Story","Ingredient","Steps"]
    
    /// initializer
    /// - Parameter recipe: `Recipe`
    required init(_ recipe: Recipe) {
        super.init(recipe)
        
        stepsVMs = recipe.steps.map{RecipeStepCellVM($0)}
        storyCellVM = RecipeStepCellVM(Step(stepDescription: recipe.story, imageUrls: [recipe.imageURL ?? ""]))
        ingredientCellVMs = recipe.ingredients.enumerated().map { (index, value) in
            return IngredientCellVM(index: index, title: value)
        }
    }
}
