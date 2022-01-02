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
    
    func getMatchedRecipes() {
        var matchs:[RecipeCellVM] = []
        ingredientCellVMs.map{$0.title}.forEach { title in
            guard let title = title else { return }
            recipeCellVMs?.forEach({ cellVM in
                let ingredients = cellVM.recipe.ingredients.filter{$0.contains(title)}
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
