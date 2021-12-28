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
    
    convenience init(id:Int, banners: [String]) {
        self.init()
        
        self.id = id
        imgsURLs = banners
    }
}
