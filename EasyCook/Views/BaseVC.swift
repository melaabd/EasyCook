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
    
    /// configure progress completions, in this comman case we show skeleton views till api response come then will hide it. it coild be overrided in some othe places
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
    
    ///  initialize refrsh controller and setup it with properties
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
    
    /// trigger action for refresh control
    @objc private func refreshScreen() {
        baseViewModel?.refresh()
    }
    
    /// navigate to RecipeDetailsVC
    /// - Parameter recipe: instantiate RecipeDetailsVC and set it's view model by passing recipe then navigate to it
    func openRecipeDetails(recipe:Recipe){
        let recipeDetailsVC = RecipeDetailsVC.getViewController()
        recipeDetailsVC.recipeDetailsVM = RecipeDetailsVM(recipe)
        navigationController?.navigationBar.isHidden = false
        navigationController?.pushViewController(recipeDetailsVC, animated: true)
    }
    
    /// show an alert with message to user
    /// - Parameters:
    ///   - title: title of alert
    ///   - msg: message body of alert
    ///   - actionTitle: button title of alert
    func showAlertWith(title:String = "Error", msg:String, actionTitle:String = "Dismiss") {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: actionTitle, style: .cancel)
        alert.addAction(dismissAction)
        present(alert, animated: true)
    }
}
