//
//  Collection.swift
//  EasyCook
//
//  Created by melaabd on 12/26/21.
//

import Foundation
import Alamofire


typealias Collections = [Collection]
typealias CollectionsAPICompletion = ((_ collections: Collections?, _ errorMsg:String?) -> Void)?

struct Collection: Codable {
    var id: Int
    var title, collectionDescription: String
    var recipeCount: Int
    var previewImageUrls: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case collectionDescription = "description"
        case recipeCount = "recipe_count"
        case previewImageUrls = "preview_image_urls"
    }
    
    
    static func getCollections(completion:CollectionsAPICompletion = nil) {
        APIManager.shared.loadRequest(router: Router.getCollections) {(response: DataResponse<Collections, AFError>) in
            switch response.result {
            case .success:
                guard let collections:Collections = response.value else {
                    completion?(nil,nil)
                    return}
                completion?(collections, nil)
            case .failure:
                completion?(nil, response.error?.localizedDescription)
            }
        }
    }
}
