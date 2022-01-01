//
//  RecipeCellVM.swift
//  EasyCook
//
//  Created by melaabd on 12/27/21.
//

import Foundation

class RecipeCellVM: BaseRecipeVM {
    
    var recipe:Recipe!
    
    required init(_ recipe: Recipe) {
        super.init(recipe)
        
        self.recipe = recipe
    }
}
