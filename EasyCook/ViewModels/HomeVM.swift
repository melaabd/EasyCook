//
//  HomeVM.swift
//  EasyCook
//
//  Created by melaabd on 12/26/21.
//

import Foundation

protocol HomeBindingDelegate: AnyObject {
    func reloadData()
    func notifyFailure(msg: String)
}

class HomeVM {
    
    var showProgress: CompletionVoid?
    var hideProgress: CompletionVoid?
    var updateMenu: CompletionVoid?
    weak var homeBindingDelegate:HomeBindingDelegate?
    
    var homeBannerTVCellVM:[HomeBannerTVCellVM]?
    var menuBarItems:[MenuItem]?
    var recipeCellVMs:[RecipeCellVM]?
    
    func getCollections() {
        showProgress?()
        Collection.getCollections { [weak self] collections, errorMsg in
            self?.hideProgress?()
            guard errorMsg == nil else {
                self?.homeBindingDelegate?.notifyFailure(msg: errorMsg!)
                return
            }
            self?.menuBarItems = []
            self?.homeBannerTVCellVM = collections?.map { [weak self] in
                self?.menuBarItems?.append(MenuItem(id: $0.id, titleName: $0.title))
                return HomeBannerTVCellVM(id: $0.id, banners: $0.previewImageUrls)
            }
            self?.updateMenu?()
            self?.homeBindingDelegate?.reloadData()
        }
    }
    
    func getRecipesWith(id:Int?) {
        showProgress?()
        Recipe.getRecipes(collectionId: id) { [weak self] recipes, errorMsg in
            self?.hideProgress?()
            guard errorMsg == nil else {
                self?.homeBindingDelegate?.notifyFailure(msg: errorMsg!)
                return
            }
            self?.recipeCellVMs = recipes?.map{RecipeCellVM($0)}
            self?.homeBindingDelegate?.reloadData()
        }
    }
}
