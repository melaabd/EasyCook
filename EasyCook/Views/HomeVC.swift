//
//  HomeVC.swift
//  EasyCook
//
//  Created by melaabd on 12/26/21.
//

import UIKit
import SkeletonView

class HomeVC: BaseVC {
    
    @IBOutlet weak var collectionsTableView: UITableView!
    
    var homeVM:HomeVM?
    var menuBar:MenuBar?
    var selectedCollection = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeVM = HomeVM()
        baseViewModel = homeVM
        homeVM?.bindingDelegate = self
        homeVM?.getCollections()
        homeVM?.updateMenu = { [weak self] in
            self?.setupHeaderMenuBar()
        }
        collectionsTableView.sectionHeaderTopPadding = 0.0
        setupRefreshController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func setupRefreshController() {
        super.setupRefreshController()
        
        if let refresher = refreshControl {
            collectionsTableView.addSubview(refresher)
        }
    }
    
    /// setup titles in the menubar after fetch it from backend
    fileprivate func setupHeaderMenuBar() {
        guard let menuItems = homeVM?.menuBarItems else { return }
        menuBar = MenuBar(menuItems: menuItems, delegate: self)
        menuBar?.isSkeletonable = true
    }
    
}

// MARK: - conform with collectionsTableView protocols
extension HomeVC: SkeletonTableViewDataSource, UITableViewDelegate {
    
    /// number of sections in skeleton view
    /// - Parameter collectionSkeletonView: the UITableView
    /// - Returns: The Int number
    func numSections(in collectionSkeletonView: UITableView) -> Int {
        numberOfSections(in: collectionSkeletonView)
    }
    
    /// number of rows in skeleton view
    /// - Parameters:
    ///   - skeletonView: the UITableView
    ///   - section: Int section index
    /// - Returns: Int number of rows in this section
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 2
        }
    }
    
    /// return identifier of cell that will show in skeleton view
    /// - Parameters:
    ///   - skeletonView: the UITableView
    ///   - indexPath: IndexPath of Item
    /// - Returns: String identifier of cell
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        if indexPath.section == 0 {
            return HomeBannerTVCell.identifier
        } else {
            return RecipeTVCell.identifier
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var noOfRowas = 0
        switch section {
        case 0:
            noOfRowas = 1
        default:
            noOfRowas = homeVM?.recipeCellVMs?.count ?? 0
        }
        noOfRowas == 0 ? tableView.setEmptyView() : tableView.setEmptyView(nil)
        return noOfRowas
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

// MARK: - Conform with MenuBar Select Index Protocol
extension HomeVC: MenuBarDelegate {
    func cellSelectedAt(index: Int) {
        selectedCollection = index
        homeVM?.getRecipes(id: selectedCollection)
    }
}

// MARK: - Conform with HomeVM Binding Protocol
extension HomeVC: BindingVVMDelegate {
    func reloadData() {
        onMain { [weak self] in
            self?.collectionsTableView.reloadData()
        }
    }
    
    func notifyFailure(msg: String) {
        showAlertWith(msg: msg)
    }
}
