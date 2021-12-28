//
//  APIManager.swift
//  EasyCook
//
//  Created by melaabd on 12/26/21.
//

import Foundation
import Alamofire

struct APIManager {
    
    static var shared = APIManager()
    var manager: Session
    private let timeOut = 240.0
    
    static var temporaryAccessToken:String = ""
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeOut
        configuration.timeoutIntervalForResource = timeOut
        manager = Session(configuration: configuration, startRequestsImmediately: true)
        
    }
    
    mutating func setManager(sesssion: Session) {
        manager = sesssion
    }
    
    func loadRequest<T: Decodable>(router:Router, completionHandler: @escaping (DataResponse<T, AFError>) -> Void) {
        manager.request(router, method: router.method, parameters: router.parameter, encoding: JSONEncoding.default, headers: router.httpHeaders)
            .validate()
            .responseDecodable(of:T.self) { response in
                completionHandler(response)
            }
    }
}
