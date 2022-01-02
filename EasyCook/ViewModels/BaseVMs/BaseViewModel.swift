//
//  BaseViewModel.swift
//  EasyCook
//
//  Created by melaabd on 12/28/21.
//

import Foundation

protocol BindingVVMDelegate: AnyObject {
    func reloadData()
    func notifyFailure(msg: String)
}

class BaseViewModel {
    
    weak var bindingDelegate:BindingVVMDelegate?
    var showProgress: CompletionVoid?
    var hideProgress: CompletionVoid?
    var recipeCellVMs:[RecipeCellVM]?
    var endRefresh:CompletionVoid?
    
    func getRecipes(id:Int? = nil, shouldReload:Bool = true) {
        showProgress?()
        Recipe.getRecipes(collectionId: id) { [weak self] recipes, errorMsg in
            self?.hideProgress?()
            guard errorMsg == nil else {
                self?.bindingDelegate?.notifyFailure(msg: errorMsg!)
                return
            }
            self?.recipeCellVMs = recipes?.map{RecipeCellVM($0)}
            shouldReload ? self?.bindingDelegate?.reloadData() : nil
        }
    }
    
    func refresh() {}
}
