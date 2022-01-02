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
    
    
    /// return router's `Parameters`
    var parameter: Parameters? {
        return nil
    }
    
    /// return router's path `String`
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
    
    /// return router's`HTTPMethod`
    var method: HTTPMethod {
        return .get
    }
    
    /// return router's `HTTPHeaders`
    var httpHeaders: HTTPHeaders {
        let header: HTTPHeaders = ["accept": "application/json"]
        return header
    }
    
    
    /// build URL
    /// - Returns: `URL`
    func asURL() throws -> URL {
        let url = try (Router.baseURL + path).asURL()
        return url
    }
    
    /// add components for url request
    /// - Returns: `URLRequest`
    func asURLRequest() throws -> URLRequest {
        var urlRequest = try getURLRequest()
        urlRequest.headers = httpHeaders
        urlRequest.method = method
        return urlRequest
    }
    
    
    /// create url request
    /// - Returns: `URLRequest`
    fileprivate func getURLRequest() throws -> URLRequest {
        let url = try (Router.baseURL + path).asURL()
        let urlRequest = URLRequest(url: url)
        return urlRequest
    }
}
