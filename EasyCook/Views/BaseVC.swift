//
//  BaseVC.swift
//  EasyCook
//
//  Created by melaabd on 12/31/21.
//

import UIKit


class BaseVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func openRecipeDetails(recipe:Recipe){
        let recipeDetailsVC = RecipeDetailsVC.getViewController()
        recipeDetailsVC.recipeDetailsVM = RecipeDetailsVM(recipe)
        navigationController?.navigationBar.isHidden = false
        navigationController?.pushViewController(recipeDetailsVC, animated: true)
    }
}
