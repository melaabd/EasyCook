//
//  RecipeCellVM.swift
//  EasyCook
//
//  Created by melaabd on 12/27/21.
//

import Foundation

class RecipeCellVM {
    
    
    var id: Int!
    var title:String?
    var imageURL: URL?
    var userPic: URL?
    var userName:String?
    var recipe:Recipe!
    
    required init(_ recipe: Recipe) {
        id = recipe.id
        title = recipe.title
        imageURL = URL(string: recipe.imageURL ?? "")
        userName = recipe.user.name
        userPic = URL(string: recipe.user.imageURL ?? "")
        self.recipe = recipe
    }
}
