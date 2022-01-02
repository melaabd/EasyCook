//
//  Recipe.swift
//  EasyCook
//
//  Created by melaabd on 12/26/21.
//

import Foundation
import Alamofire

typealias Recipes = [Recipe]
typealias RecipesAPICompletion = ((_ recipes: Recipes?, _ errorMsg:String?) -> Void)?

struct Recipe: Codable {
    var id: Int
    var title, story: String
    var imageURL: String?
    var publishedAt: String
    var user: User
    var ingredients: [String]
    var steps: [Step]
    
    enum CodingKeys: String, CodingKey {
        case id, title, story
        case imageURL = "image_url"
        case publishedAt = "published_at"
        case user, ingredients, steps
    }
    
    /// fetch recipes from backend
    /// - Parameters:
    ///   - collectionId: `Int` collection id  could be nill if we need to fetch all recipes
    ///   - completion: `RecipesAPICompletion`
    static func getRecipes(collectionId:Int? = nil, completion:RecipesAPICompletion = nil) {
        var router: Router {
            return collectionId == nil ? Router.getAllRecipes : Router.getCollectionRecipesWith(id: collectionId!)
        }
        APIManager.shared.loadRequest(router: router) {(response: DataResponse<Recipes, AFError>) in
            switch response.result {
            case .success:
                guard let recipes:Recipes = response.value else {
                    completion?(nil, nil)
                    return}
                completion?(recipes, nil)
            case .failure:
                completion?(nil, response.error?.localizedDescription)
            }
        }
    }
    
}
