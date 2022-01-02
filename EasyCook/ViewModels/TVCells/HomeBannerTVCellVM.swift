//
//  HomeBannerTVCellVM.swift
//  EasyCook
//
//  Created by melaabd on 12/26/21.
//

import Foundation


class HomeBannerTVCellVM {
    
    var id:Int!
    var imgsURLs:[String]?
    
    /// initialize banner cell view model by id and array of url strings
    /// - Parameters:
    ///   - id: Int Id
    ///   - banners: array of  String
    convenience init(id:Int, banners: [String]) {
        self.init()
        
        self.id = id
        imgsURLs = banners
    }
}
