//
//  BaseViewModel.swift
//  EasyCook
//
//  Created by melaabd on 12/28/21.
//

import Foundation

/// Binding delegate to connect between VC and VM
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
    
    /// fetch recipes from server
    /// - Parameters:
    ///   - id: id of collection that we need to fetch it's recipe if it's left nil as default it's will fetch all recipes
    ///   - shouldReload: to till if reload needed in VC or not because there are some cases it's just used to store data in viewmodel
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
    
    /// refresh control trigger function it's will ve overrided in subclasses 
    func refresh() {}
}
