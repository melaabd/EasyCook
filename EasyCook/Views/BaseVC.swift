//
//  BaseVC.swift
//  EasyCook
//
//  Created by melaabd on 12/31/21.
//

import UIKit
import SkeletonView


class BaseVC: UIViewController {
    
    var baseViewModel:BaseViewModel? {
        didSet {
            configureProgress()
        }
    }
    
    var refreshControl: UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func configureProgress() {
        baseViewModel?.showProgress = {
            onMain { [weak self] in
                self?.view.isSkeletonable = true
                self?.view.showAnimatedGradientSkeleton()
            }
        }
        
        baseViewModel?.hideProgress = {
            onMain { [weak self] in
                self?.view.hideSkeleton()
            }
        }
    }
    
    func setupRefreshController() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "EasyCook")
        refreshControl?.addTarget(self, action: #selector(refreshScreen), for: .valueChanged)
        baseViewModel?.endRefresh = {
            onMain { [weak self] in
                self?.refreshControl?.endRefreshing()
            }
        }
    }
    
    @objc private func refreshScreen() {
        baseViewModel?.refresh()
    }
    
    func openRecipeDetails(recipe:Recipe){
        let recipeDetailsVC = RecipeDetailsVC.getViewController()
        recipeDetailsVC.recipeDetailsVM = RecipeDetailsVM(recipe)
        navigationController?.navigationBar.isHidden = false
        navigationController?.pushViewController(recipeDetailsVC, animated: true)
    }
}
