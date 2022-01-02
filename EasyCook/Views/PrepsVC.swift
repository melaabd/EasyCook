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
    
    /// indecator for API calls
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        return aiv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepsVM = PrepsVM()
        baseViewModel = prepsVM
        prepsVM?.bindingDelegate = self
        prepsVM?.getRecipes(shouldReload: false)
        setupRefreshController()
    }
    
    override func setupRefreshController() {
        super.setupRefreshController()
        
        /// add refresh control to view
        if let refresher = refreshControl {
            prepsTableView.addSubview(refresher)
        }
    }
    
    /// ovveride progress configration regerding to need in this VC
    override func configureProgress() {
        view.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        prepsVM?.showProgress = {
            onMain { [weak self] in
                self?.view.isUserInteractionEnabled = false
                self?.activityIndicatorView.startAnimating()
            }
        }
        
        prepsVM?.hideProgress = {
            onMain { [weak self] in
                self?.view.isUserInteractionEnabled = true
                self?.activityIndicatorView.stopAnimating()
            }
        }
    }
    
    /// insert or remove particular row in tableview to look good while adding or removing items from view
    /// - Parameters:
    ///   - title: the string will be showen in the row
    ///   - index: IndexPath of row that will be added or removed
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

// MARK: - conform with prepsTableView protocols 
extension PrepsVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var noOfRowas = 0
        switch section {
        case 0:
            noOfRowas = (prepsVM?.ingredientCellVMs.count ?? 0) + 1
        default:
            noOfRowas = prepsVM?.filteredRecipeCellVM?.count ?? 0
        }
        noOfRowas == 0 ? tableView.setEmptyView() : tableView.setEmptyView(nil)
        return noOfRowas
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

// MARK: - Conform with PrepsVM Binding Protocol
extension PrepsVC: BindingVVMDelegate {
    
    func reloadData() {
        onMain { [weak self] in
            self?.prepsTableView.reloadData()
        }
    }
    
    func notifyFailure(msg: String) {
        showAlertWith(msg: msg)
    }
}
