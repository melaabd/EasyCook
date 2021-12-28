//
//  Router.swift
//  EasyCook
//
//  Created by melaabd on 12/26/21.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible, URLConvertible {
    
    static let baseURL = "https://cookpad.github.io/global-mobile-hiring/api/"
    
    case getCollections
    case getCollectionRecipesWith(id: Int)
    case getAllRecipes
    
    var parameter: Parameters? {
        return nil
    }
    
    var path : String {
        switch self {
        case .getCollections:
            return "collections/"
        case .getCollectionRecipesWith(let id):
            return "collections/\(id)/recipes/"
        case .getAllRecipes:
            return "recipes/"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var httpHeaders: HTTPHeaders {
        let header: HTTPHeaders = ["accept": "application/json"]
        return header
    }
    
    func asURL() throws -> URL {
        let url = try (Router.baseURL + path).asURL()
        return url
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = try getURLRequest()
        urlRequest.headers = httpHeaders
        urlRequest.method = method
        return urlRequest
    }
    
    
    fileprivate func getURLRequest() throws -> URLRequest {
        let url = try (Router.baseURL + path).asURL()
        let urlRequest = URLRequest(url: url)
        return urlRequest
    }
}
