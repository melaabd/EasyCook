//
//  RecipeDetailsVC.swift
//  EasyCook
//
//  Created by melaabd on 12/31/21.
//

import UIKit
import SDWebImage

class RecipeDetailsVC: UIViewController {
    
    @IBOutlet weak var recipeTableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var recipeTitleLbl: UILabel!
    
    var recipeDetailsVM:RecipeDetailsVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = UserNavigationView(userName: recipeDetailsVM.userName ?? "", imgUrl: recipeDetailsVM.userPic)
        recipeTitleLbl.text = recipeDetailsVM.title
        recipeTableView.reloadData()
    }
    
    private func createHeaderView(title: String) -> UIView {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: recipeTableView.frame.width, height: 40))
        headerView.backgroundColor = Theme.floor.color
        let label = UILabel()
        label.layer.cornerRadius = 4
        label.text = title
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(label)
        label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 5).isActive = true
        label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10).isActive = true
        label.topAnchor.constraint(equalToSystemSpacingBelow: headerView.topAnchor, multiplier: 0).isActive = true
        label.bottomAnchor.constraint(equalToSystemSpacingBelow: headerView.bottomAnchor, multiplier: 0).isActive = true
        return headerView
    }
}

extension RecipeDetailsVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return recipeDetailsVM.ingredientCellVMs?.count ?? 0
        default:
            return recipeDetailsVM.stepsVMs?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: IngredientTVCell.identifier) as? IngredientTVCell ?? IngredientTVCell()
            cell.ingredientCellVM = recipeDetailsVM.ingredientCellVMs?[indexPath.row]
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeStepTVCell.identifier) as? RecipeStepTVCell ?? RecipeStepTVCell()
        cell.recipeStepCellVM = (indexPath.section == 0) ? recipeDetailsVM.storyCellVM : recipeDetailsVM.stepsVMs?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return createHeaderView(title: recipeDetailsVM.sectionsTitles[section])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
