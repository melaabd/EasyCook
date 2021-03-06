//
//  PrepsVM.swift
//  EasyCook
//
//  Created by melaabd on 12/26/21.
//

import Foundation


class PrepsVM: BaseViewModel {
    
    
    var filteredRecipeCellVM:[RecipeCellVM]?
    var ingredientCellVMs:[IngredientCellVM] = [] {
        didSet {
            if ingredientCellVMs.count == 0 {
                getMatchedRecipes()
            }
        }
    }
    
    /// filter the array of `RecipeCellVM` regarding to the matchs with ingredients
    func getMatchedRecipes() {
        var matchs:[RecipeCellVM] = []
        ingredientCellVMs.map{$0.title}.forEach { title in
            guard let title = title?.lowercased() else { return }
            recipeCellVMs?.forEach({ cellVM in
                let ingredients = cellVM.recipe.ingredients.filter{$0.lowercased().contains(title)}
                if ingredients.count > 0 {
                    matchs.append(cellVM)
                }
            })
        }
        filteredRecipeCellVM = matchs
        bindingDelegate?.reloadData()
    }
    
    override func refresh() {
        ingredientCellVMs = []
        getRecipes(shouldReload: false)
        endRefresh?()
    }
}
