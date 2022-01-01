//
//  HomeVC.swift
//  EasyCook
//
//  Created by melaabd on 12/26/21.
//

import UIKit

class HomeVC: BaseVC {
    
    @IBOutlet weak var collectionsTableView: UITableView!
    
    var homeVM:HomeVM?
    var menuBar:MenuBar?
    var selectedCollection = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeVM = HomeVM()
        homeVM?.bindingDelegate = self
        homeVM?.getCollections()
        homeVM?.updateMenu = { [weak self] in
            self?.setupHeaderMenuBar()
        }
        collectionsTableView.sectionHeaderTopPadding = 0.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    fileprivate func setupHeaderMenuBar() {
        guard let menuItems = homeVM?.menuBarItems else { return }
        menuBar = MenuBar(menuItems: menuItems, delegate: self)
    }
    
}

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return homeVM?.recipeCellVMs?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeBannerTVCell.identifier) as? HomeBannerTVCell ?? HomeBannerTVCell()
            cell.homeBannerTVCellVM = homeVM?.homeBannerTVCellVM?.first{$0.id == selectedCollection}
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTVCell.identifier) as? RecipeTVCell ?? RecipeTVCell()
            cell.recipeCellVM = homeVM?.recipeCellVMs?[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (section > 0) ? 40 : 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return (section > 0) ? menuBar : nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let recipe = homeVM?.recipeCellVMs?[indexPath.row].recipe else { return }
        openRecipeDetails(recipe: recipe)
    }
}

extension HomeVC: MenuBarDelegate {
    func cellSelectedAt(index: Int) {
        selectedCollection = index
        homeVM?.getRecipes(id: selectedCollection)
    }
}

extension HomeVC: BindingVVMDelegate {
    func reloadData() {
        onMain { [weak self] in
            self?.collectionsTableView.reloadData()
        }
    }
    
    func notifyFailure(msg: String) {
        print(msg)
    }
}
