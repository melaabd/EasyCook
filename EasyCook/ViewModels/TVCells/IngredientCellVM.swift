//
//  IngredientCellVM.swift
//  EasyCook
//
//  Created by melaabd on 12/30/21.
//

import Foundation

class IngredientCellVM {
    
    var index:Int!
    var title:String!
    
    required init(index:Int, title:String) {
        
        self.index = index
        self.title = title
    }
}
