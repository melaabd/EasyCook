//
//  PrepsVC.swift
//  EasyCook
//
//  Created by melaabd on 12/26/21.
//

import UIKit

class PrepsVC: BaseVC {
    
    @IBOutlet weak var prepsTableView: UITableView!
    
    var prepsVM:PrepsVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepsVM = PrepsVM()
        prepsVM?.bindingDelegate = self
    }
    
    
    private func insertOrRemoveRow(title: String? = nil, index: IndexPath) {
        if let itemTitle = title {
            prepsTableView.beginUpdates()
            prepsTableView.insertRows(at: [IndexPath(row: (prepsVM?.ingredientCellVMs.count ?? 0), section: 0)], with: .automatic)
            prepsVM?.ingredientCellVMs.append(IngredientCellVM(index: index.row, title: itemTitle))
            prepsTableView.endUpdates()
        } else {
            prepsVM?.ingredientCellVMs.remove(at: index.row)
        }
        prepsTableView.reloadData()
    }
    
}

extension PrepsVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return (prepsVM?.ingredientCellVMs.count ?? 0) + 1
        default:
            return prepsVM?.filteredRecipeCellVM?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row < (prepsVM?.ingredientCellVMs.count ?? 0) {
                let cell = tableView.dequeueReusableCell(withIdentifier: IngredientTVCell.identifier) as? IngredientTVCell ?? IngredientTVCell()
                cell.ingredientCellVM = prepsVM?.ingredientCellVMs[indexPath.row]
                
                cell.removeCompletion = { [weak self] in
                    self?.insertOrRemoveRow(index: indexPath)
                }
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: AddIngredientTVCell.identifier) as? AddIngredientTVCell ?? AddIngredientTVCell()
                
                cell.ingredientsCount = prepsVM?.ingredientCellVMs.count ?? 0
                
                cell.addItemCompletion = { [weak self] title  in
                    self?.insertOrRemoveRow(title: title, index: indexPath)
                }
                
                cell.findRecipesCompletion = { [weak self] in
                    self?.prepsVM?.getMatchedRecipes()
                }
                
                cell.sizeChangeCompletion = {
                    onMain { [weak self] in
                        self?.prepsTableView.beginUpdates()
                        self?.prepsTableView.endUpdates()
                    }
                }
                return cell
            }
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTVCell.identifier) as? RecipeTVCell ?? RecipeTVCell()
            cell.recipeCellVM = prepsVM?.filteredRecipeCellVM?[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section > 0, let recipe = prepsVM?.recipeCellVMs?[indexPath.row].recipe else { return }
        openRecipeDetails(recipe: recipe)
    }
}

extension PrepsVC: BindingVVMDelegate {
    
    func reloadData() {
        onMain { [weak self] in
            self?.prepsTableView.reloadData()
        }
    }
    
    func notifyFailure(msg: String) {
        print(msg)
    }
}
