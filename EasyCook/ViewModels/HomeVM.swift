//
//  HomeVM.swift
//  EasyCook
//
//  Created by melaabd on 12/26/21.
//

import Foundation

class HomeVM: BaseViewModel {
    
    var updateMenu: CompletionVoid?
    var homeBannerTVCellVM:[HomeBannerTVCellVM]?
    var menuBarItems:[MenuItem]?
    
    func getCollections() {
        showProgress?()
        Collection.getCollections { [weak self] collections, errorMsg in
            self?.hideProgress?()
            guard errorMsg == nil else {
                self?.bindingDelegate?.notifyFailure(msg: errorMsg!)
                return
            }
            self?.menuBarItems = []
            self?.homeBannerTVCellVM = collections?.map { [weak self] in
                self?.menuBarItems?.append(MenuItem(id: $0.id, titleName: $0.title))
                return HomeBannerTVCellVM(id: $0.id, banners: $0.previewImageUrls)
            }
            self?.updateMenu?()
            self?.bindingDelegate?.reloadData()
        }
    }
    
    override func refresh() {
        getCollections()
        endRefresh?()
    }
    
}
