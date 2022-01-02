//
//  BaseRecipeVM.swift
//  EasyCook
//
//  Created by melaabd on 12/31/21.
//

import Foundation


class BaseRecipeVM {
    
    var id: Int!
    var title:String?
    var imageURL: URL?
    var userPic: URL?
    var userName:String?
    
    /// intializer
    /// - Parameter recipe: `Recipe`
    required init(_ recipe: Recipe) {
        id = recipe.id
        title = recipe.title
        imageURL = URL(string: recipe.imageURL ?? "")
        userName = recipe.user.name
        userPic = URL(string: recipe.user.imageURL ?? "")
    }
}
