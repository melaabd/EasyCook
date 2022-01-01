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
    
    var recipeDetailsVM:RecipeDetailsVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = UserNavigationView(userName: recipeDetailsVM.userName ?? "", imgUrl: recipeDetailsVM.userPic)
        recipeTableView.sectionHeaderTopPadding = 0.0
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
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 2:
            return recipeDetailsVM.ingredientCellVMs?.count ?? 0
        case 3:
            return recipeDetailsVM.stepsVMs?.count ?? 0
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = UITableViewCell()
            cell.backgroundColor = .clear
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.font = .boldSystemFont(ofSize: 24)
            cell.textLabel?.text = recipeDetailsVM.title
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: IngredientTVCell.identifier) as? IngredientTVCell ?? IngredientTVCell()
            cell.ingredientCellVM = recipeDetailsVM.ingredientCellVMs?[indexPath.row]
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: RecipeStepTVCell.identifier) as? RecipeStepTVCell ?? RecipeStepTVCell()
            cell.recipeStepCellVM = (indexPath.section == 0) ? recipeDetailsVM.storyCellVM : recipeDetailsVM.stepsVMs?[indexPath.row]
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return section > 0 ? createHeaderView(title: recipeDetailsVM.sectionsTitles[section-1]) : nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section > 0 ? 30 : 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
